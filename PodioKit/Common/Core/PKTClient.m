//
//  PKTSessionManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTClient.h"
#import "PKTOAuth2Token.h"
#import "PKTTokenStore.h"
#import "PKTAuthenticationAPI.h"
#import "PKTMacros.h"
#import "NSMutableURLRequest+PKTHeaders.h"
#import "NSError+PKTErrors.h"

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
@property (nonatomic, weak, readwrite) PKTAsyncTask *authenticationTask;
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

- (instancetype)initWithAPIKey:(NSString *)key secret:(NSString *)secret {
  PKTClient *client = [self init];
  [client setupWithAPIKey:key secret:secret];
  
  return client;
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
  NSParameterAssert(key);
  NSParameterAssert(secret);
  
  self.apiKey = key;
  self.apiSecret = secret;
  
  [self updateAuthorizationHeader:self.isAuthenticated];
}

#pragma mark - Authentication

- (PKTAsyncTask *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password {
  NSParameterAssert(email);
  NSParameterAssert(password);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithEmail:email password:password];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious];
}

- (PKTAsyncTask *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious];
}

- (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);
  
  self.savedAuthenticationRequest = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
}

- (PKTAsyncTask *)authenticateWithRequest:(PKTRequest *)request requestPolicy:(PKTClientAuthRequestPolicy)requestPolicy {
  if (requestPolicy == PKTClientAuthRequestPolicyIgnore) {
    if (self.authenticationTask) {
      // Ignore this new authentation request, let the old one finish
      return nil;
    }
  } else if (requestPolicy == PKTClientAuthRequestPolicyCancelPrevious) {
    // Cancel any pending authentication task
    [self.authenticationTask cancel];
  }

  PKT_WEAK_SELF weakSelf = self;

  // Always use basic authentication for authentication requests
  request.URLRequestConfigurationBlock = ^NSURLRequest *(NSURLRequest *urlRequest) {
      PKT_STRONG(weakSelf) strongSelf = weakSelf;

      NSMutableURLRequest *mutURLRequest = [urlRequest mutableCopy];
      [mutURLRequest pkt_setAuthorizationHeaderWithUsername:strongSelf.apiKey password:strongSelf.apiSecret];

      return [mutURLRequest copy];
  };

  self.authenticationTask = [self performTaskWithRequest:request];
  
  [self.authenticationTask onComplete:^(PKTResponse *response, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    if (!error) {
      strongSelf.oauthToken = [[PKTOAuth2Token alloc] initWithDictionary:response.body];
    } else if ([error pkt_isServerError]) {
      // If authentication failed server side, reset the token since it isn't likely
      // to be successful next time either. If it is NOT a server side error, it might
      // just be networking so we should not reset the token.
      strongSelf.oauthToken = nil;
    }
    
    strongSelf.authenticationTask = nil;
  }];

  return self.authenticationTask;
}

- (PKTAsyncTask *)authenticateWithSavedRequest:(PKTRequest *)request {
  PKTAsyncTask *task = [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore];
  
  [task onSuccess:^(id result) {
    [self processPendingTasks];
  } onError:^(NSError *error) {
    [self clearPendingTasks];
  }];
  
  return task;
}

#pragma mark - Requests

- (PKTAsyncTask *)performRequest:(PKTRequest *)request {
  NSAssert(self.apiKey && self.apiSecret, @"You need to configure PodioKit with an API key and secret. Call [PodioKit setupWithAPIKey:secret:] bofore making any requests using PodioKit.");
  
  PKTAsyncTask *task = nil;
  
  if (self.isAuthenticated) {
    // Authenticated request, might need token refresh
    if (![self.oauthToken willExpireWithinIntervalFromNow:kTokenExpirationLimit]) {
      task = [self performTaskWithRequest:request];
    } else {
      task = [self enqueueTaskWithRequest:request];
      [self refreshToken];
    }
  } else if (self.savedAuthenticationRequest) {
    // Can self-authenticate, authenticate before performing request
    task = [self enqueueTaskWithRequest:request];
    [self authenticateWithSavedRequest:self.savedAuthenticationRequest];
  } else {
    // Unauthenticated request
    task = [self performTaskWithRequest:request];
  }
  
  return task;
}

- (PKTAsyncTask *)performTaskWithRequest:(PKTRequest *)request {
  __block NSURLSessionTask *sessionTask = nil;
  
  PKTAsyncTask *task = [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    sessionTask = [self.HTTPClient taskForRequest:request completion:^(PKTResponse *response, NSError *error) {
      if (!error) {
        [resolver succeedWithResult:response];
      } else {
        [resolver failWithError:error];
      }
    }];
    
    PKT_WEAK(sessionTask) weakSessionTask = sessionTask;
    
    return ^{
      [weakSessionTask cancel];
    };
  }];
  
  [sessionTask resume];
  
  return task;
}

- (PKTAsyncTask *)enqueueTaskWithRequest:(PKTRequest *)request {
  __block NSURLSessionTask *sessionTask = nil;
  
  PKTAsyncTask *task = [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    sessionTask = [self.HTTPClient taskForRequest:request completion:^(PKTResponse *response, NSError *error) {
      if (!error) {
        [resolver succeedWithResult:response];
      } else {
        [resolver failWithError:error];
      }
    }];
    
    PKT_WEAK(sessionTask) weakSessionTask = sessionTask;
    
    return ^{
      [weakSessionTask cancel];
    };
  }];
  
  [self.pendingTasks addObject:sessionTask];
  
  return task;
}

- (void)processPendingTasks {
  for (NSURLSessionTask *task in self.pendingTasks) {
    [task resume];
  }
  
  [self.pendingTasks removeAllObjects];
}

- (void)clearPendingTasks {
  for (NSURLSessionTask *task in self.pendingTasks) {
    [task cancel];
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

- (PKTAsyncTask *)refreshTokenWithRefreshToken:(NSString *)refreshToken {
  NSParameterAssert(refreshToken);

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore];
}

- (PKTAsyncTask *)refreshToken {
  NSAssert([self.oauthToken.refreshToken length] > 0, @"Can't refresh session, refresh token is missing.");

  PKTAsyncTask *task = [self refreshTokenWithRefreshToken:self.oauthToken.refreshToken];
  
  [task onSuccess:^(id result) {
    [self processPendingTasks];
  } onError:^(NSError *error) {
    [self clearPendingTasks];
  }];
  
  return task;
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context == kIsAuthenticatedContext) {
    BOOL isAuthenticated = [change[NSKeyValueChangeNewKey] boolValue];
    [self authenticationStateDidChange:isAuthenticated];
  }
}

@end
