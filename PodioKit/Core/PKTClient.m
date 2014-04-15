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

@interface PKTClient ()


@property (nonatomic, copy, readwrite) NSString *apiKey;
@property (nonatomic, copy, readwrite) NSString *apiSecret;
@property (nonatomic, strong, readwrite) PKTOAuth2Token *oauthToken;

@end

@implementation PKTClient

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
  [self authenticateWithRequest:request completion:completion];
}

- (void)authenticateWithAppID:(NSString *)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
  [self authenticateWithRequest:request completion:completion];
}

- (void)authenticateWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  @synchronized(self) {
    PKT_WEAK_SELF weakSelf = self;
    
    [self.HTTPClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
      PKT_STRONG(weakSelf) strongSelf = weakSelf;

      PKTOAuth2Token *token = nil;
      if (!error) {
        token = [[PKTOAuth2Token alloc] initWithDictionary:response.parsedData];
      }
      
      strongSelf.oauthToken = token;

      if (completion) {
        completion(response, error);
      }
    }];
  }
}

#pragma mark - Requests

- (NSURLSessionTask *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  // TODO: Check token expiration, refresh etc
  return [self.HTTPClient performRequest:request completion:completion];
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

- (void)refreshSessionWithRefreshToken:(NSString *)refreshToken completion:(PKTRequestCompletionBlock)completion {
  NSParameterAssert(refreshToken);

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];
  [self authenticateWithRequest:request completion:completion];
}

- (void)refreshSessionToken:(PKTRequestCompletionBlock)completion {
  NSAssert([self.oauthToken.refreshToken length] > 0, @"Can't refresh session, refresh token is missing.");

  [self refreshSessionWithRefreshToken:self.oauthToken.refreshToken completion:completion];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (context == kIsAuthenticatedContext) {
    BOOL isAuthenticated = change[NSKeyValueChangeNewKey];
    [self authenticationStateDidChange:isAuthenticated];
  }
}

@end
