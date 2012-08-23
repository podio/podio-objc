//
//  PKAPIClient.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
#import "PKAPIRequest.h"
#import "PKRequestOperation.h"
#import "PKFileOperation.h"
#import "PKOAuth2Client.h"


// Notifications
extern NSString * const PKAPIClientWillBeginAuthentication;
extern NSString * const PKAPIClientDidFinishAuthentication;

extern NSString * const PKAPIClientDidAuthenticateUser;
extern NSString * const PKAPIClientAuthenticationFailed;

extern NSString * const PKAPIClientWillRefreshAccessToken;
extern NSString * const PKAPIClientDidRefreshAccessToken;

extern NSString * const PKAPIClientTokenRefreshFailed;
extern NSString * const PKAPIClientNeedsReauthentication;

extern NSString * const PKAPIClientRequestFinished;
extern NSString * const PKAPIClientRequestFailed;

extern NSString * const PKAPIClientNoInternetConnection;

// Notification user info keys
extern NSString * const PKAPIClientRequestKey;
extern NSString * const PKAPIClientTokenKey;
extern NSString * const PKAPIClientResponseDataKey;

@interface PKAPIClient : NSObject <ASIHTTPRequestDelegate, PKOAuth2ClientDelegate> {

 @private
  NSString *baseURLString_;
  NSString *fileUploadURLString_;
  NSString *fileDownloadURLString_;
  NSString *userAgent_;
  
  ASINetworkQueue *networkQueue_;
  ASINetworkQueue *serialNetworkQueue_;
  PKOAuth2Client *oauthClient_;
  PKOAuth2Token *authToken_;
  
  NSMutableArray *pendingRequests_;
  
  BOOL isRefreshingToken_;
  BOOL isAuthenticating_;
}

@property (nonatomic, copy) NSString *baseURLString;
@property (nonatomic, copy) NSString *fileUploadURLString;
@property (nonatomic, copy) NSString *fileDownloadURLString;
@property (nonatomic, copy) NSString *userAgent;
@property (nonatomic, strong) PKOAuth2Token *authToken;

+ (PKAPIClient *)sharedClient;

- (void)configureWithClientId:(NSString *)clientId secret:(NSString *)secret;
- (void)configureWithClientId:(NSString *)clientId secret:(NSString *)secret baseURLString:(NSString *)baseURLString;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password;

- (void)refreshToken;
- (void)refreshUsingRefreshToken:(NSString *)refreshToken;
- (void)handleUnauthorized;

- (BOOL)isAuthenticated;

- (NSString *)URLStringForPath:(NSString *)path parameters:(NSDictionary *)parameters;

- (BOOL)addRequestOperation:(PKRequestOperation *)operation;
- (BOOL)addFileOperation:(PKFileOperation *)operation;

@end
