//
//  PKTSessionManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTSessionManager.h"
#import "PKTAuthenticationAPI.h"
#import "PKTClient.h"

@interface PKTSessionManager ()

@property (nonatomic, strong, readwrite) PKTOAuth2Token *oauthToken;

@end

@implementation PKTSessionManager

+ (instancetype)sharedManager {
  static PKTSessionManager *sharedManager;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedManager = [self new];
  });
  
  return sharedManager;
}

- (instancetype)init {
  @synchronized(self) {
    self = [super init];
    if (!self) return nil;
    
    return self;
  }
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

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTSessionAuthenticationBlock)completion {
  NSParameterAssert(email);
  NSParameterAssert(password);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithEmail:email password:password];
  [self authenticateWithRequest:request completion:completion];
}

- (void)authenticateWithAppID:(NSString *)appID token:(NSString *)appToken completion:(PKTSessionAuthenticationBlock)completion {
  NSParameterAssert(appID);
  NSParameterAssert(appToken);

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];
  [self authenticateWithRequest:request completion:completion];
}

#pragma mark - Refresh token

- (void)refreshSessionWithRefreshToken:(NSString *)refreshToken completion:(PKTSessionAuthenticationBlock)completion {
  NSParameterAssert(refreshToken);

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];
  [self authenticateWithRequest:request completion:completion];
}

- (void)refreshSession:(PKTSessionAuthenticationBlock)completion {
  NSAssert([self.oauthToken.refreshToken length] > 0, @"Can't refresh session, refresh token is missing.");
  if ([self.oauthToken.refreshToken length] == 0) {
    return;
  }

  [self refreshSessionWithRefreshToken:self.oauthToken.refreshToken completion:completion];
}

#pragma mark - Private

- (void)authenticateWithRequest:(PKTRequest *)request completion:(PKTSessionAuthenticationBlock)completion {
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
        completion(token, error);
      }
    }];
  }
}

@end
