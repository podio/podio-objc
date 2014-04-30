//
//  PKTCategoryItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCategoryItemFieldValue.h"

@implementation PKTCategoryItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _optionID = [valueDictionary[@"value"][@"id"] copy];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : self.optionID};
}

- (void)setUnboxedValue:(id)unboxedValue {
  NSAssert([unboxedValue isKindOfClass:[NSNumber class]], @"The unboxed value for category value needs to be an NSNumber representing the option ID.");
  self.optionID = unboxedValue;
}

- (id)unboxedValue {
  return self.optionID;
}

@end
