//
//  PKTSessionManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTSessionManager.h"

@implementation PKTSessionManager

+ (instancetype)sharedManager {
  static PKTSessionManager *sharedManager;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedManager = [[self alloc] init];
  });
  
  return sharedManager;
}

- (instancetype)init {
  @synchronized(self) {
    self = [super init];
    
    return self;
  }
}

@end
