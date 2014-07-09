//
//  PKTSessionManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTClient.h"
#import "PKTRequestTaskDescriptor.h"
#import "PKTOAuth2Token.h"
#import "PKTTokenStore.h"
#import "PKTAuthenticationAPI.h"
#import "PKTMacros.h"
#import "NSMutableURLRequest+PKTHeaders.h"

NSString * const PKTClientAuthenticationStateDidChangeNotification = @"PKTClientAuthenticationStateDidChangeNotification";

static void * kIsAuthenticatedContext = &kIsAuthenticatedContext;
static NSUInteger const kTokenExpirationLimit = 10 * 60; // 10 minutes

typedef NS_ENUM(NSUInteger, PKTClientAuthRequestPolicy) {
  PKTClientAuthRequestPolicyCancelPrevious = 0,
  PKTClientAuthRequestPolicyIgnore,
};

@interface PKTClient ()

@property (nonatomic, copy, readwrite) NSString *apiKey;
@property (nonatomic, copy, readwrite) NSString *apiSecret;
@property (nonatomic, weak, readwrite) PKTRequestTaskDescriptor *authenticationTask;
@property (nonatomic, strong, readwrite) PKTRequest *savedAuthenticationRequest;
@property (nonatomic, strong, readonly) NSMutableOrderedSet *pendingTasks;

@end

@implementation PKTClient

@synthesize pendingTasks = _pendingTasks;

+ (instancetype)defaultClient {
  static PKTClient *defaultClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    defaultClient = [self new];
  });
  
  return defaultClient;
}

- (id)init {
  PKTHTTPClient *httpClient = [PKTHTTPClient new];
  PKTClient *client = [self initWithHTTPClient:httpClient];
  
  return client;
}

- (instancetype)initWithHTTPClient:(PKTHTTPClient *)client {
  @synchronized(self) {
    self = [super init];
    if (!self) return nil;

    _HTTPClient = client;

    [self updateAuthorizationHeader:self.isAuthenticated];

    [self addObserver:self forKeyPath:NSStringFromSelector(@selector(isAuthenticated)) options:NSKeyValueObservingOptionNew context:kIsAuthenticatedContext];
    
    return self;
  }
}

- (void)dealloc {
  [self removeObserver:self forKeyPath:NSStringFromSelector(@selector(isAuthenticated)) context:kIsAuthenticatedContext];
}

#pragma mark - Properties

- (BOOL)isAuthenticated {
  return self.oauthToken != nil;
}

- (void)setOauthToken:(PKTOAuth2Token *)oauthToken {
  if (oauthToken == _oauthToken) return;

  NSString *isAuthenticatedKey = NSStringFromSelector(@selector(isAuthenticated));
  [self willChangeValueForKey:isAuthenticatedKey];

  _oauthToken = oauthToken;

  [self didChangeValueForKey:isAuthenticatedKey];
}

- (NSMutableOrderedSet *)pendingTasks {
  if (!_pendingTasks) {
    _pendingTasks = [[NSMutableOrderedSet alloc] init];
  }
  
  return _pendingTasks;
}

#pragma mark - Clients

+ (void)pushClient:(PKTClient *)client {
  [[self clientStack] addObject:client];
}

+ (void)popClient {
  [[self clientStack] removeLastObject];
}

+ (instancetype)currentClient {
  return [[self clientStack] lastObject] ?: [self defaultClient];
}

+ (NSMutableArray *)clientStack {
  static NSMutableArray *clientStack = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    clientStack = [NSMutableArray new];
  });

  return clientStack;
}

- (void)performBlock:(void (^)(void))block {
  NSParameterAssert(block);
  
  [[self class] pushClient:self];
  block();
  [[self class] popClient];
}

#pragma mark - Configuration

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret {
  self.apiKey = key;
  self.apiSecret = secret;
  
  [self updateAuthorizationHeader:self.isAuthenticated];
}

#pragma mark - Authentication

- (PKTRequestTaskDescriptor *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(email);
  NSParameterAssert(password);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithEmail:email password:password];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious completion:completion];
}

- (PKTRequestTaskDescriptor *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious completion:completion];
}

- (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);
  
  self.savedAuthenticationRequest = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
}

- (PKTRequestTaskDescriptor *)authenticateWithRequest:(PKTRequest *)request requestPolicy:(PKTClientAuthRequestPolicy)requestPolicy completion:(PKTRequestCompletionBlock)completion {
  if (requestPolicy == PKTClientAuthRequestPolicyIgnore) {
    if (self.authenticationTask) {
      // Ignore this new authentation request, let the old one finish
      return nil;
    }
  } else if (requestPolicy == PKTClientAuthRequestPolicyCancelPrevious) {
    // Cancel any pending authentication task
    [self.authenticationTask cancelWithClient:self.HTTPClient];
  }

  PKT_WEAK_SELF weakSelf = self;

  // Always use basic authentication for authentication requests
  request.URLRequestConfigurationBlock = ^NSURLRequest *(NSURLRequest *urlRequest) {
      PKT_STRONG(weakSelf) strongSelf = weakSelf;

      NSMutableURLRequest *mutURLRequest = [urlRequest mutableCopy];
      [mutURLRequest pkt_setAuthorizationHeaderWithUsername:strongSelf.apiKey password:strongSelf.apiSecret];

      return [mutURLRequest copy];
  };

  self.authenticationTask = [self performTaskWithRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;

    PKTOAuth2Token *token = nil;
    if (!error) {
      token = [[PKTOAuth2Token alloc] initWithDictionary:response.body];
    }

    if (response.statusCode > 0) {
      strongSelf.oauthToken = token;
    }

    if (completion) {
      completion(response, error);
    }

    strongSelf.authenticationTask = nil;
  }];

  return self.authenticationTask;
}

- (PKTRequestTaskDescriptor *)authenticateWithSavedRequest:(PKTRequest *)request {
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore completion:^(PKTResponse *response, NSError *error) {
    if (!error) {
      [self processPendingTasks];
    } else {
      [self clearPendingTasks];
    }
  }];
}

#pragma mark - Requests

- (PKTRequestTaskHandle *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSAssert(self.apiKey && self.apiSecret, @"You need to configure PodioKit with an API key and secret. Call [PodioKit setupWithAPIKey:secret:] bofore making any requests using PodioKit.");
  
  PKTRequestTaskDescriptor *descriptor = nil;
  
  if (self.isAuthenticated) {
    // Authenticated request, might need token refresh
    if (![self.oauthToken willExpireWithinIntervalFromNow:kTokenExpirationLimit]) {
      descriptor = [self performTaskWithRequest:request completion:completion];
    } else {
      descriptor = [self enqueueTaskWithRequest:request completion:completion];
      [self refreshToken];
    }
  } else if (self.savedAuthenticationRequest) {
    // Can self-authenticate, authenticate before performing request
    descriptor = [self enqueueTaskWithRequest:request completion:completion];
    [self authenticateWithSavedRequest:self.savedAuthenticationRequest];
  } else {
    // Unauthenticated request
    descriptor = [self performTaskWithRequest:request completion:completion];
  }
  
  return [PKTRequestTaskHandle handleForDescriptor:descriptor];
}

- (PKTRequestTaskDescriptor *)performTaskWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  PKTRequestTaskDescriptor *descriptor = [PKTRequestTaskDescriptor descriptorWithRequest:request completion:completion];
  [descriptor startWithClient:self.HTTPClient];
  
  return descriptor;
}

- (PKTRequestTaskDescriptor *)enqueueTaskWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  PKTRequestTaskDescriptor *descriptor = [PKTRequestTaskDescriptor descriptorWithRequest:request completion:completion];
  [self.pendingTasks addObject:descriptor];
  
  return descriptor;
}

- (void)processPendingTasks {
  for (PKTRequestTaskDescriptor *descriptor in self.pendingTasks) {
    [descriptor startWithClient:self.HTTPClient];
  }
  
  [self.pendingTasks removeAllObjects];
}

- (void)clearPendingTasks {
  for (PKTRequestTaskDescriptor *descriptor in self.pendingTasks) {
    [descriptor cancelWithClient:self.HTTPClient];
  }
  
  [self.pendingTasks removeAllObjects];
}

#pragma mark - State

- (void)authenticationStateDidChange:(BOOL)isAuthenticated {
  [self updateAuthorizationHeader:isAuthenticated];
  [self updateStoredToken];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:PKTClientAuthenticationStateDidChangeNotification object:self];
}

- (void)updateAuthorizationHeader:(BOOL)isAuthenticated {
  if (isAuthenticated) {
    [self.HTTPClient.requestSerializer setAuthorizationHeaderWithOAuth2AccessToken:self.oauthToken.accessToken];
  } else if (self.apiKey && self.apiSecret) {
    [self.HTTPClient.requestSerializer setAuthorizationHeaderWithAPIKey:self.apiKey secret:self.apiSecret];
  }
}

- (void)updateStoredToken {
  if (!self.tokenStore) return;
  
  PKTOAuth2Token *token = self.oauthToken;
  if (token) {
    [self.tokenStore storeToken:token];
  } else {
    [self.tokenStore deleteStoredToken];
  }
}

- (void)restoreTokenIfNeeded {
  if (!self.tokenStore) return;
  
  if (!self.isAuthenticated) {
    self.oauthToken = [self.tokenStore storedToken];
  }
}

#pragma mark - Refresh token

- (PKTRequestTaskDescriptor *)refreshTokenWithRefreshToken:(NSString *)refreshToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(refreshToken);

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore completion:completion];
}

- (PKTRequestTaskDescriptor *)refreshToken:(PKTRequestCompletionBlock)completion {
  NSAssert([self.oauthToken.refreshToken length] > 0, @"Can't refresh session, refresh token is missing.");

  return [self refreshTokenWithRefreshToken:self.oauthToken.refreshToken completion:completion];
}

- (PKTRequestTaskDescriptor *)refreshToken {
  return [self refreshToken:^(PKTResponse *response, NSError *error) {
    if (!error) {
      [self processPendingTasks];
    } else {
      [self clearPendingTasks];
    }
  }];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context == kIsAuthenticatedContext) {
    BOOL isAuthenticated = [change[NSKeyValueChangeNewKey] boolValue];
    [self authenticationStateDidChange:isAuthenticated];
  }
}

@end
