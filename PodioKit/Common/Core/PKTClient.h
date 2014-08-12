//
//  PKTSessionManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTHTTPClient.h"
#import "PKTAsyncTask.h"

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

/**
 *  The default API client.
 *
 *  @return The default client.
 */
+ (instancetype)defaultClient;

/**
 *  The current API client. The current client for a give scope can be changed by 
 *  using the performBlock: method.
 *
 *  @see performBlock:
 *
 *  @return The current client.
 */
+ (instancetype)currentClient;

/**
 *  The designated initializer. Calling the default init method will instantiate a new HTTP client
 *  instance and pass it to this method.
 *
 *  @param client The HTTP client for the client to use for creating HTTP requests.
 *
 *  @return The initialized client.
 */
- (instancetype)initWithHTTPClient:(PKTHTTPClient *)client;

/**
 *  Initialize a client with an API key and secret. This is equivalent to calling -init followed by
 *  setupWithAPIKey:secret:.
 *
 *  @param key    The Podio API key
 *  @param secret The Podio API secret matching the key
 *
 *  @return The initialized client.
 */
- (instancetype)initWithAPIKey:(NSString *)key secret:(NSString *)secret;

/** Configure the default client with a Podio API key/secret pair.
 *
 * @see https://developers.podio.com/api-key
 *
 * @param key The Podio API key
 * @param secret The Podio API secret matching the key
 */
- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret;

/**
 *  Execute a block for which the current client is self. This is useful to force the use
 *  of a client instead of the default client for a certain scope, and enabled multiple clients to 
 *  work in parallel.
 *
 *  @see currentClient
 *
 *  @param block The block for which the current client should be self.
 */
- (void)performBlock:(void (^)(void))block;

/** Authenticate the default client as a user with an email and password.
 *
 *  @see https://developers.podio.com/authentication/username_password
 *
 *  @param email The user's email address
 *  @param password The user's password
 *
 *  @return The resulting task.
 */
- (PKTAsyncTask *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password;

/** Authenticate the default client as an app.
 *
 *  @see https://developers.podio.com/authentication/app_auth
 *
 *  @param appID The ID of the application to authenticate as.
 *  @param appToken The app token string associated with the app.
 *
 *  @return The resulting task.
 */
- (PKTAsyncTask *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken;

/** Configure authentication parameters for authenticating the default client as an app.
 *
 * Instead of authenticating immediately, this method configures the default client to use the
 * app ID and token to authenticate once whenever a request is performed without the client being
 * authenticated.
 *
 * @param appID The id of the application to authenticate as.
 * @param appToken The app token string associated with the app.
 */
- (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken;

/**
 *  Dispatches an HTTP request task for the provided request.
 *
 *  @param request    The request to perform.
 *
 *  @return The resulting task.
 */
- (PKTAsyncTask *)performRequest:(PKTRequest *)request;

/**
 *  Will attempt to restore the OAuth token from the current tokenStore if one has been configured.
 *
 *  @see tokenStore
 */
- (void)restoreTokenIfNeeded;

@end
