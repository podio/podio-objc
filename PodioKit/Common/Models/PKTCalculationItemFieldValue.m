//
//  PKTCalculationItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCalculationItemFieldValue.h"

@implementation PKTCalculationItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  // Skip validation since we are setting this internally
  [self setUnboxedValue:valueDictionary[@"value"] validate:NO];
  
  return self;
}

@end
