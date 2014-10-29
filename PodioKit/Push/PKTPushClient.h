//
//  PKTPushClient.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTPushSubscription.h"
#import "PKTPushEvent.h"
#import "PKTPushCredential.h"

@interface PKTPushClient : NSObject

+ (PKTPushClient *)sharedClient;

- (PKTPushSubscription *)subscribeWithCredential:(PKTPushCredential *)credential eventBlock:(void (^)(PKTPushEvent *event))block;

- (void)unsubscribe:(PKTPushSubscription *)subscription;

@end
