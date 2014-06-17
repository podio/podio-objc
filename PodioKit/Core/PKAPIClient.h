//
//  PKAPIClient.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/29/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <SystemConfiguration/SystemConfiguration.h>
#import <AFNetworking/AFNetworking.h>
#import "PKRequest.h"
#import "PKOAuth2Token+PKAuthorizationHeader.h"

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

- (NSURLRequest *)requestForAuthenticationWithSSOBody:(NSDictionary *)body;
- (NSURLRequest *)requestForAuthenticationWithGrantType:(NSString *)grantType body:(NSDictionary *)body;
- (NSURLRequest *)requestForAuthenticationWithEmail:(NSString *)email password:(NSString *)password;
- (NSURLRequest *)requestForRefreshWithRefreshToken:(NSString *)refreshToken;

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
- (NSMutableURLRequest *)requestWithURL:(NSURL *)url;

// Operations
- (PKHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request completion:(PKRequestCompletionBlock)completion;

- (BOOL)performOperation:(PKHTTPRequestOperation *)operation;

@end
