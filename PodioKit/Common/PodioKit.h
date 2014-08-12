//
//  PodioKit.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTGlobalHeaders.h"

/**
 The PodioKit class contains a set of convenience methods to configure the default PKTClient instance.
 */
@interface PodioKit : NSObject

/** Configure the default client with a Podio API key/secret pair.
 *
 * @see https://developers.podio.com/api-key
 *
 * @param key The Podio API key
 * @param secret The Podio API secret matching the key
 */
+ (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret;

/** Authenticate the default client as a user with an email and password.
 *
 * @see https://developers.podio.com/authentication/username_password
 *
 * @param email The user's email address
 * @param password The user's password
 * @param completion The completion block to be called once the authentication attempt completes either successfully or with an error.
 *
 * @return The resulting request task.
 */
+ (PKTAsyncTask *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password;

/** Authenticate the default client as an app.
 *
 * @see https://developers.podio.com/authentication/app_auth
 *
 * @param appID The ID of the application to authenticate as.
 * @param appToken The app token string associated with the app.
 * @param completion The completion block to be called once the authentication attempt completes either successfully or with an error.
 *
 * @return The resulting request task.
 */
+ (PKTAsyncTask *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken;

/** Configure authentication parameters for authenticating the default client as an app.
 *
 * Instead of authenticating immediately, this method configures the default client to use the
 * app ID and token to authenticate once whenever a request is performed without the client being
 * authenticated.
 *
 * @param appID The id of the application to authenticate as.
 * @param appToken The app token string associated with the app.
 */
+ (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken;

/** Informs the caller whether the default client is authenticated or not, i.e. has an active OAuth token.
 *
 * @return YES if the default client is authenticated, otherwise NO.
 */
+ (BOOL)isAuthenticated;

/** Configure the default client to store the OAuth token in the user Keychain.
 *
 * @param name The Service name to use when storing the token in the keychain.
 */
+ (void)automaticallyStoreTokenInKeychainForServiceWithName:(NSString *)name;

/** Configure the default client to store the OAuth token in the user Keychain. The bundle identifier will be used as the Service name for this Keychain item.
 */
+ (void)automaticallyStoreTokenInKeychainForCurrentApp;

@end
