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

@interface PKTClient : AFHTTPSessionManager

@property (nonatomic, copy, readonly) NSString *apiKey;
@property (nonatomic, copy, readonly) NSString *apiSecret;

+ (instancetype)sharedClient;

- (instancetype)initWithAPIKey:(NSString *)key secret:(NSString *)secret;

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret;

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header;

- (void)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion;

@end
