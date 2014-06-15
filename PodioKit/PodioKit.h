//
//  PodioKit.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTGlobalHeaders.h"

@interface PodioKit : NSObject

+ (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret;

+ (AFHTTPRequestOperation *)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion;
+ (AFHTTPRequestOperation *)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion;
+ (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken;
+ (BOOL)isAuthenticated;

+ (void)automaticallyStoreTokenInKeychainForServiceWithName:(NSString *)name;
+ (void)automaticallyStoreTokenInKeychainForCurrentApp;

@end
