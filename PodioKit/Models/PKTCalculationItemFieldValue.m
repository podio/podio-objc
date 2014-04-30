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
  self = [super init];
  if (!self) return nil;
  
  _value = valueDictionary[@"value"];
  
  return self;
}

- (id)unboxedValue {
  return self.value;
}

@end
