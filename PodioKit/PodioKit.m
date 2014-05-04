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

+ (void)authenticateAsUserWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion {
  [[PKTClient sharedClient] authenticateAsUserWithEmail:email password:password completion:completion];
}

+ (void)authenticateAsAppWithID:(NSUInteger)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion {
  [[PKTClient sharedClient] authenticateAsAppWithID:appID token:appToken completion:completion];
}

+ (void)authenticateAutomaticallyAsAppWithID:(NSUInteger)appID token:(NSString *)appToken {
  [[PKTClient sharedClient] authenticateAutomaticallyAsAppWithID:appID token:appToken];
}

@end
