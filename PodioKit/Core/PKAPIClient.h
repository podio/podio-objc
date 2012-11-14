//
//  PKAPIClient.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASINetworkQueue.h"
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
extern NSString * const PKAPIClientErrorKey;

/**
 Singleton class responsible for handling all API interaction, from authentication to request handling.
 */
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

 

/** Configures the client for API access with the base URL string of [https://api.podio.com](https://api.podio.com)
 
 @param clientId A Podio API client id.
 @param secret A Podio API client secret for the corresponding client id.
 @see configureWithClientId:secret:baseURLString:
 */
- (void)configureWithClientId:(NSString *)clientId secret:(NSString *)secret;

/** Configures the client for API access.
 
 @param clientId A Podio API client id.
 @param secret A Podio API client secret for the corresponding client id.
 @param baseURLString The Podio API base URL string.
 */
- (void)configureWithClientId:(NSString *)clientId secret:(NSString *)secret baseURLString:(NSString *)baseURLString;

/** Authenticate a user with username/password.
 
 @param email The username.
 @param password The password.
 */
- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password;

/** Authenticate a user with a custom grant type.
 
 @param grantType The grant type.
 @param body The POST body parameters.
 */
- (void)authenticateWithGrantType:(NSString *)grantType body:(NSDictionary *)body;

/** Force a access token refresh with the current refresh token.
 */
- (void)refreshToken;

/** Force a access token refresh with a particular refresh token.
 
 @param refreshToken The refresh token to use to refresh the access token.
 */
- (void)refreshUsingRefreshToken:(NSString *)refreshToken;

/** Checks if there client has a valid token.
 
 @return YES if there is a valid token.
 */
- (BOOL)isAuthenticated;

/** Call when the API returns unauthorized HTTP response.
 */
- (void)handleUnauthorized;

/** Returns the full URL string for a path and a number of query parameters based on the configured base URL.
 
 @param path The resource path.
 @param parameters A dictionary of query parameters. The query parameter values have to be of type NSString.
 @return The full URL string.
 */
- (NSString *)URLStringForPath:(NSString *)path parameters:(NSDictionary *)parameters;

/** Add a request operation to the network queue.
 
 @param operation The request operation.
 @return YES if the operation was added to the queue.
 */
- (BOOL)addRequestOperation:(PKRequestOperation *)operation;

/** Add a file operation to the network queue.
 
 @param operation The file operation.
 @return YES if the operation was added to the queue.
 */
- (BOOL)addFileOperation:(PKFileOperation *)operation;

@end
