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
  [[PKTClient defaultClient] setupWithAPIKey:key secret:secret];
}

+ (AFHTTPRequestOperation *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion {
  return [[PKTClient defaultClient] authenticateAsUserWithEmail:email password:password completion:completion];
}

+ (AFHTTPRequestOperation *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
  return [[PKTClient defaultClient] authenticateAsAppWithID:appID token:appToken completion:completion];
}

+ (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  [[PKTClient defaultClient] authenticateAutomaticallyAsAppWithID:appID token:appToken];
}

+ (BOOL)isAuthenticated {
  return [[PKTClient defaultClient] isAuthenticated];
}

+ (void)automaticallyStoreTokenInKeychainForServiceWithName:(NSString *)name {
  [PKTClient defaultClient].tokenStore = [[PKTKeychainTokenStore alloc] initWithService:name];
  [[PKTClient defaultClient] restoreTokenIfNeeded];
}

+ (void)automaticallyStoreTokenInKeychainForCurrentApp {
  NSString *name = [[NSBundle mainBundle] objectForInfoDictionaryKey:(__bridge id)kCFBundleIdentifierKey];
  [self automaticallyStoreTokenInKeychainForServiceWithName:name];
}

@end
