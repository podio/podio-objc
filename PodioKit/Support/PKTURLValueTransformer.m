//
//  PKTURLValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTURLValueTransformer.h"

@implementation PKTURLValueTransformer

- (instancetype)init {
  return [super initWithBlock:^id(NSString *URLString) {
    return [NSURL URLWithString:URLString];
  }];
}

@end
