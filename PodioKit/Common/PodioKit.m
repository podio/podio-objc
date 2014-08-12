//
//  PodioKit.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PodioKit.h"
#import "PKTClient.h"

@implementation PodioKit

+ (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret {
  [[PKTClient currentClient] setupWithAPIKey:key secret:secret];
}

+ (PKTAsyncTask *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password {
  return [[PKTClient currentClient] authenticateAsUserWithEmail:email password:password];
}

+ (PKTAsyncTask *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  return [[PKTClient currentClient] authenticateAsAppWithID:appID token:appToken];
}

+ (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  [[PKTClient currentClient] authenticateAutomaticallyAsAppWithID:appID token:appToken];
}

+ (BOOL)isAuthenticated {
  return [[PKTClient currentClient] isAuthenticated];
}

+ (void)automaticallyStoreTokenInKeychainForServiceWithName:(NSString *)name {
  [PKTClient currentClient].tokenStore = [[PKTKeychainTokenStore alloc] initWithService:name];
  [[PKTClient currentClient] restoreTokenIfNeeded];
}

+ (void)automaticallyStoreTokenInKeychainForCurrentApp {
  NSString *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge id)kCFBundleIdentifierKey];
  [self automaticallyStoreTokenInKeychainForServiceWithName:name];
}

@end
