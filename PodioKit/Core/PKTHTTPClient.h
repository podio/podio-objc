//
//  PKTClient.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@class PKTRequest, PKTResponse;

typedef void(^PKTRequestCompletionBlock)(PKTResponse *response, NSError *error);

@interface PKTHTTPClient : AFHTTPSessionManager

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header;
- (void)setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken;
- (void)setAuthorizationHeaderWithAPIKey:(NSString *)key secret:(NSString *)secret;

- (NSURLSessionTask *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion;

@end
