//
//  PKTSessionManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTHTTPClient.h"

extern NSString * const PKTClientAuthenticationStateDidChangeNotification;

@class PKTOAuth2Token;
@protocol PKTTokenStore;

@interface PKTClient : NSObject

@property (nonatomic, copy, readonly) NSString *apiKey;
@property (nonatomic, copy, readonly) NSString *apiSecret;
@property (nonatomic, strong, readonly) PKTHTTPClient *HTTPClient;
@property (nonatomic, strong, readwrite) PKTOAuth2Token *oauthToken;
@property (nonatomic, assign, readonly) BOOL isAuthenticated;
@property (nonatomic, strong) id<PKTTokenStore> tokenStore;

+ (instancetype)sharedClient;

- (instancetype)initWithHTTPClient:(PKTHTTPClient *)client;

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret;

- (AFHTTPRequestOperation *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion;
- (AFHTTPRequestOperation *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion;
- (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken;

- (AFHTTPRequestOperation *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion;

- (void)restoreTokenIfNeeded;

@end
