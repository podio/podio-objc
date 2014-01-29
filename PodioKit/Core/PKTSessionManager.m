//
//  PKTSessionManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTSessionManager.h"
#import "PKTOAuth2Token.h"
#import "PKTAuthenticationAPI.h"

static void * kIsAuthenticatedContext = &kIsAuthenticatedContext;

@interface PKTSessionManager ()

@property (nonatomic, strong, readwrite) PKTOAuth2Token *oauthToken;

@end

@implementation PKTSessionManager

+ (instancetype)sharedManager {
  static PKTSessionManager *sharedManager;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedManager = [[self alloc] initWithClient:[PKTClient sharedClient]];
  });
  
  return sharedManager;
}

- (instancetype)initWithClient:(PKTClient *)client {
  @synchronized(self) {
    self = [super init];
    if (!self) return nil;

    _client = client;

    [self setupAuthorizationHeader:[self isAuthenticated]];

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
    __block __weak __typeof(&*self)weakSelf = self;
    [[PKTClient sharedClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
      __strong __typeof(&*weakSelf)strongSelf = weakSelf;

      PKTOAuth2Token *token = nil;
      if (!error) {
        // TODO: map the response into a native object
        //token = [PKTOAuth2Token tokenFromDictionary:response.];
      }
      strongSelf.oauthToken = token;

      if (completion) {
        completion(response, error);
      }
    }];
  }
}

#pragma mark - State

- (void)authenticationStateDidChange:(BOOL)isAuthenticated {
  [self setupAuthorizationHeader:isAuthenticated];
}

- (void)setupAuthorizationHeader:(BOOL)isAuthenticated {
  if (isAuthenticated) {
    [self.client setAuthorizationHeaderWithOAuth2AccessToken:self.oauthToken.accessToken];
  } else {
    [self.client setAuthorizationHeaderWithAPICredentials];
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
  if ([self.oauthToken.refreshToken length] == 0) {
    return;
  }

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
