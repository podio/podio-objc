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
  
  self.unboxedValue = [valueDictionary[@"value"][@"id"] copy];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : self.unboxedValue};
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return [value isKindOfClass:[NSNumber class]];
}

@end
