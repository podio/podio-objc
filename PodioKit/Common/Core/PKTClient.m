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
@property (nonatomic, weak, readwrite) AFHTTPRequestOperation *authenticationOperation;
@property (nonatomic, strong, readwrite) PKTRequest *savedAuthenticationRequest;
@property (nonatomic, strong, readonly) NSMutableOrderedSet *pendingOperations;

@end

@implementation PKTClient

@synthesize pendingOperations = _pendingOperations;

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

- (NSMutableOrderedSet *)pendingOperations {
  if (!_pendingOperations) {
    _pendingOperations = [[NSMutableOrderedSet alloc] init];
  }
  
  return _pendingOperations;
}

#pragma mark - Configuration

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret {
  self.apiKey = key;
  self.apiSecret = secret;
  
  [self updateAuthorizationHeader:self.isAuthenticated];
}

#pragma mark - Authentication

- (AFHTTPRequestOperation *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(email);
  NSParameterAssert(password);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithEmail:email password:password];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyCancelPrevious completion:completion];
}

- (AFHTTPRequestOperation *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
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

- (AFHTTPRequestOperation *)authenticateWithRequest:(PKTRequest *)request requestPolicy:(PKTClientAuthRequestPolicy)requestPolicy completion:(PKTRequestCompletionBlock)completion {
  if (requestPolicy == PKTClientAuthRequestPolicyIgnore) {
    if (self.authenticationOperation) {
      // Ignore this new authentation request, let the old one finish
      return nil;
    }
  } else if (requestPolicy == PKTClientAuthRequestPolicyCancelPrevious) {
    // Cancel any pending authentication task
    [self.authenticationOperation cancel];
  }

  PKT_WEAK_SELF weakSelf = self;

  // Always use basic authentication for authentication requests
  request.URLRequestConfigurationBlock = ^NSURLRequest *(NSURLRequest *urlRequest) {
      PKT_STRONG(weakSelf) strongSelf = weakSelf;

      NSMutableURLRequest *mutURLRequest = [urlRequest mutableCopy];
      [mutURLRequest pkt_setAuthorizationHeaderWithUsername:strongSelf.apiKey password:strongSelf.apiSecret];

      return [mutURLRequest copy];
  };

  self.authenticationOperation = [self performOperationkWithRequest:request completion:^(PKTResponse *response, NSError *error) {
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

    strongSelf.authenticationOperation = nil;
  }];

  return self.authenticationOperation;
}

- (AFHTTPRequestOperation *)authenticateWithSavedRequest:(PKTRequest *)request {
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore completion:^(PKTResponse *response, NSError *error) {
    if (!error) {
      [self processPendingOperations];
    } else {
      [self clearPendingOperations];
    }
  }];
}

#pragma mark - Requests

- (AFHTTPRequestOperation *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  AFHTTPRequestOperation *operation = nil;
  
  if (self.isAuthenticated) {
    // Authenticated request, might need token refresh
    if (![self.oauthToken willExpireWithinIntervalFromNow:kTokenExpirationLimit]) {
      operation = [self performOperationkWithRequest:request completion:completion];
    } else {
      operation = [self enqueueOperationWithRequest:request completion:completion];
      [self refreshToken];
    }
  } else if (self.savedAuthenticationRequest) {
    // Can self-authenticate, authenticate before performing request
    operation = [self enqueueOperationWithRequest:request completion:completion];
    [self authenticateWithSavedRequest:self.savedAuthenticationRequest];
  } else {
    // Unauthenticated request
    operation = [self performOperationkWithRequest:request completion:completion];
  }
  
  return operation;
}

- (AFHTTPRequestOperation *)performOperationkWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  AFHTTPRequestOperation *operation = [self.HTTPClient operationWithRequest:request completion:completion];
  [operation start];
  
  return operation;
}

- (AFHTTPRequestOperation *)enqueueOperationWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  AFHTTPRequestOperation *operation = [self.HTTPClient operationWithRequest:request completion:completion];
  [self.pendingOperations addObject:operation];
  
  return operation;
}

- (void)processPendingOperations {
  for (AFHTTPRequestOperation *operation in self.pendingOperations) {
    [operation start];
  }
  
  [self.pendingOperations removeAllObjects];
}

- (void)clearPendingOperations {
  for (AFHTTPRequestOperation *operation in self.pendingOperations) {
    [operation cancel];
    [operation start];
  }
  
  [self.pendingOperations removeAllObjects];
}

#pragma mark - State

- (void)authenticationStateDidChange:(BOOL)isAuthenticated {
  [self updateAuthorizationHeader:isAuthenticated];
  [self updateStoredToken];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:PKTClientAuthenticationStateDidChangeNotification object:self];
}

- (void)updateAuthorizationHeader:(BOOL)isAuthenticated {
  if (isAuthenticated) {
    [self.HTTPClient setAuthorizationHeaderWithOAuth2AccessToken:self.oauthToken.accessToken];
    
    // Update all pending tasks with the new access token
    for (AFHTTPRequestOperation *operation in self.pendingOperations) {
      if ([operation.request isKindOfClass:[NSMutableURLRequest class]]) {
        [(NSMutableURLRequest *)operation.request pkt_setAuthorizationHeaderWithOAuth2AccessToken:self.oauthToken.accessToken];
      }
    }
  } else if (self.apiKey && self.apiSecret) {
    [self.HTTPClient setAuthorizationHeaderWithAPIKey:self.apiKey secret:self.apiSecret];
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

- (AFHTTPRequestOperation *)refreshTokenWithRefreshToken:(NSString *)refreshToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(refreshToken);

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];
  return [self authenticateWithRequest:request requestPolicy:PKTClientAuthRequestPolicyIgnore completion:completion];
}

- (AFHTTPRequestOperation *)refreshToken:(PKTRequestCompletionBlock)completion {
  NSAssert([self.oauthToken.refreshToken length] > 0, @"Can't refresh session, refresh token is missing.");

  return [self refreshTokenWithRefreshToken:self.oauthToken.refreshToken completion:completion];
}

- (AFHTTPRequestOperation *)refreshToken {
  return [self refreshToken:^(PKTResponse *response, NSError *error) {
    if (!error) {
      [self processPendingOperations];
    } else {
      [self clearPendingOperations];
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
