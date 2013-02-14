//
//  PKAPIClient.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/29/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "AFHTTPClient.h"
#import "PKRequest.h"

// Notifications
extern NSString * const PKAPIClientWillBeginAuthentication;
extern NSString * const PKAPIClientDidFinishAuthentication;

extern NSString * const PKAPIClientDidAuthenticateUser;
extern NSString * const PKAPIClientAuthenticationFailed;

extern NSString * const PKAPIClientWillRefreshAccessToken;
extern NSString * const PKAPIClientDidRefreshAccessToken;

extern NSString * const PKAPIClientTokenRefreshFailed;
extern NSString * const PKAPIClientNeedsReauthentication;

// Notification user info keys
extern NSString * const PKAPIClientTokenKey;
extern NSString * const PKAPIClientErrorKey;

@class PKHTTPRequestOperation, PKOAuth2Token;

@interface PKAPIClient : AFHTTPClient

@property (copy) NSString *apiKey;
@property (copy) NSString *apiSecret;
@property (nonatomic, copy) NSString *baseURLString;
@property (nonatomic, copy) NSString *userAgent;

@property (nonatomic, strong) PKOAuth2Token *oauthToken;

- (id)initWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret;

- (void)configureWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret;

+ (PKAPIClient *)sharedClient;

// Authentication
- (BOOL)isAuthenticated;
- (void)needsAuthentication;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKRequestCompletionBlock)completion;
- (void)authenticateWithSSOBody:(NSDictionary *)body completion:(PKRequestCompletionBlock)completion;

- (void)refreshOAuthToken;

// Requests
- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
                                      body:(id)body;

- (NSMutableURLRequest *)uploadRequestWithFilePath:(NSString *)path fileName:(NSString *)fileName;
- (NSMutableURLRequest *)uploadRequestWithData:(NSData *)data mimeType:(NSString *)mimeType fileName:(NSString *)fileName;

// Operations
- (PKHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request completion:(PKRequestCompletionBlock)completion;

- (BOOL)performOperation:(PKHTTPRequestOperation *)operation;

@end
