//
//  PKTSessionManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTClient.h"
#import "PKTOAuth2Token.h"
#import "PKTResponse.h"
#import "PKTAuthenticationAPI.h"
#import "PKTMacros.h"

static void * kIsAuthenticatedContext = &kIsAuthenticatedContext;
static NSUInteger const kTokenExpirationLimit = 10 * 60; // 10 minutes

typedef NS_ENUM(NSUInteger, PKTClientAuthRequestPolicy) {
  PKTClientAuthRequestPolicyCancelPrevious = 0,
  PKTClientAuthRequestPolicyIgnore,
};

@interface PKTClient ()

@property (nonatomic, copy, readwrite) NSString *apiKey;
@property (nonatomic, copy, readwrite) NSString *apiSecret;
@property (nonatomic, weak, readwrite) NSURLSessionTask *authenticationTask;
@property (nonatomic, strong, readonly) NSMutableOrderedSet *pendingTasks;

@end

@implementation PKTClient

@synthesize pendingTasks = _pendingTasks;

+ (instancetype)sharedClient {
  static PKTClient *sharedClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedClient = [self new];
  });
  
  return sharedClient;
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

#pragma mark - Configuration

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret {
  self.apiKey = key;
  self.apiSecret = secret;
}

#pragma mark - Authentication

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(email);
  NSParameterAssert(password);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithEmail:email password:password];
  [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious completion:completion];
}

- (void)authenticateWithAppID:(NSString *)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
  [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious completion:completion];
}

- (void)authenticateWithRequest:(PKTRequest *)request requestPolicy:(PKTClientAuthRequestPolicy)requestPolicy completion:(PKTRequestCompletionBlock)completion {
  if (requestPolicy == PKTClientAuthRequestPolicyIgnore) {
    if (self.authenticationTask) {
      // Ignore this new authentation request, let the old one finish
      return;
    }
  } else if (requestPolicy == PKTClientAuthRequestPolicyCancelPrevious) {
    // Cancel any pending authentication task
    [self.authenticationTask cancel];
  }
  
  PKT_WEAK_SELF weakSelf = self;
  
  self.authenticationTask = [self performTaskWithRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;

    PKTOAuth2Token *token = nil;
    if (!error) {
      token = [[PKTOAuth2Token alloc] initWithDictionary:response.resultObject];
    }
    
    if (response.statusCode > 0) {
      strongSelf.oauthToken = token;
    }

    if (completion) {
      completion(response, error);
    }
    
    self.authenticationTask = nil;
  }];
}

#pragma mark - Requests

- (NSURLSessionTask *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLSessionTask *task = nil;
  
  if (self.isAuthenticated) {
    // Authenticated request, might need token refresh
    if ([self.oauthToken willExpireWithinIntervalFromNow:kTokenExpirationLimit]) {
      task = [self performTaskWithRequest:request completion:completion];
    } else {
      task = [self enqueueTaskWithRequest:request completion:completion];
      [self refreshToken:^(PKTResponse *response, NSError *error) {
        if (!error) {
          [self processPendingTasks];
        } else {
          [self clearPendingTasks];
        }
      }];
    }
  } else {
    // Unauthenticated request
    task = [self performTaskWithRequest:request completion:completion];
  }
  
  return nil;
}

- (NSURLSessionTask *)performTaskWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLSessionTask *task = [self.HTTPClient taskWithRequest:request completion:completion];
  [task resume];
  
  return task;
}

- (NSURLSessionTask *)enqueueTaskWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLSessionTask *task = [self.HTTPClient taskWithRequest:request completion:completion];
  [self.pendingTasks addObject:task];
  
  return task;
}

- (void)processPendingTasks {
  for (NSURLSessionTask *task in self.pendingTasks) {
    // TODO: Update auth header
    [task resume];
  }
  
  [self clearPendingTasks];
}

- (void)clearPendingTasks {
  [self.pendingTasks removeAllObjects];
}

#pragma mark - State

- (void)authenticationStateDidChange:(BOOL)isAuthenticated {
  [self updateAuthorizationHeader:isAuthenticated];
}

- (void)updateAuthorizationHeader:(BOOL)isAuthenticated {
  if (isAuthenticated) {
    [self.HTTPClient setAuthorizationHeaderWithOAuth2AccessToken:self.oauthToken.accessToken];
  } else {
    [self.HTTPClient setAuthorizationHeaderWithAPIKey:self.apiKey secret:self.apiSecret];
  }
}

#pragma mark - Refresh token

- (void)refreshTokenWithRefreshToken:(NSString *)refreshToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(refreshToken);

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];
  [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore completion:completion];
}

- (void)refreshToken:(PKTRequestCompletionBlock)completion {
  NSAssert([self.oauthToken.refreshToken length] > 0, @"Can't refresh session, refresh token is missing.");

  [self refreshTokenWithRefreshToken:self.oauthToken.refreshToken completion:completion];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context == kIsAuthenticatedContext) {
    BOOL isAuthenticated = [change[NSKeyValueChangeNewKey] boolValue];
    [self authenticationStateDidChange:isAuthenticated];
  }
}

@end
