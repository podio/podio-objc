//
//  PKTSessionManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTHTTPClient.h"

@class PKTOAuth2Token;

@interface PKTClient : NSObject

@property (nonatomic, copy, readonly) NSString *apiKey;
@property (nonatomic, copy, readonly) NSString *apiSecret;
@property (nonatomic, strong, readonly) PKTHTTPClient *HTTPClient;
@property (nonatomic, strong, readonly) PKTOAuth2Token *oauthToken;
@property (nonatomic, assign, readonly) BOOL isAuthenticated;

+ (instancetype)sharedClient;

- (instancetype)initWithHTTPClient:(PKTHTTPClient *)client;

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion;
- (void)authenticateWithAppID:(NSString *)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion;

- (NSURLSessionTask *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion;

@end
