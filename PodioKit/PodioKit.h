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

+ (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion;
+ (void)authenticateWithAppID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion;
+ (void)authenticateAutomaticallyWithAppID:(NSUInteger)appID token:(NSString *)appToken;

@end
