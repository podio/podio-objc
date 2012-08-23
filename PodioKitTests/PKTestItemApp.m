//
//  PKTestItemApp.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTestItemApp.h"

@implementation PKTestItemApp

@synthesize appId = appId_;
@synthesize name = name_;

- (id)init {
  self = [super init];
  if (self) {
    appId_ = nil;
    name_ = nil;
  }
  return self;
}

#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObjects:@"appId", nil];
}

@end
