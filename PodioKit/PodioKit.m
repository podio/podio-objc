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
  [[PKTClient sharedClient] setupWithAPIKey:key secret:secret];
}

+ (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion {
  [[PKTClient sharedClient] authenticateWithEmail:email password:password completion:completion];
}

+ (void)authenticateWithAppID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
  [[PKTClient sharedClient] authenticateWithAppID:appID token:appToken completion:completion];
}

+ (void)authenticateAutomaticallyWithAppID:(NSUInteger)appID token:(NSString *)appToken {
  [[PKTClient sharedClient] authenticateAutomaticallyWithAppID:appID token:appToken];
}

@end
