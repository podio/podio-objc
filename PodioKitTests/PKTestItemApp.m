//
//  PKTestItemApp.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
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

- (void)dealloc {
  [appId_ release], appId_ = nil;
  [name_ release], name_ = nil;
  [super dealloc];
}

#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObjects:@"appId", nil];
}

@end
