//
//  PKTPushSubscription.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTPushSubscription.h"
#import "PKTPushClient.h"

@interface PKTPushSubscription ()

@property (nonatomic, weak) PKTPushClient *service;

@end

@implementation PKTPushSubscription

- (void)unsubscribe {
  [self.service unsubscribe:self];
}

@end
