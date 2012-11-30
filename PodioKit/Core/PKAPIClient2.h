//
//  PKAPIClient2.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/29/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "AFHTTPClient.h"
#import "PKRequest.h"

@class PKHTTPRequestOperation, PKOAuth2Token;

@interface PKAPIClient2 : AFHTTPClient

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, copy) NSString *apiSecret;
@property (nonatomic, copy) NSString *userAgent; // Default is nil

@property (nonatomic, strong, readonly) PKOAuth2Token *oauthToken;

- (id)initWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret;

+ (id)sharedClient;

// Authentication
- (BOOL)isAuthenticated;

- (void)authenticateWithGrantType:(NSString *)grantType body:(NSDictionary *)body completion:(PKRequestCompletionBlock)completion;
- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKRequestCompletionBlock)completion;

// Operations
- (PKHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request completion:(PKRequestCompletionBlock)completion;
- (BOOL)performOperation:(PKHTTPRequestOperation *)operation;

@end
