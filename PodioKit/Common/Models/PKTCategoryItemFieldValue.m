//
//  PKTCategoryItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCategoryItemFieldValue.h"
#import "PKTCategoryOption.h"

@implementation PKTCategoryItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;

  self.unboxedValue = [[PKTCategoryOption alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTCategoryOption *option = self.unboxedValue;
  
  NSDictionary *dict = nil;
  
  if ([self.unboxedValue isKindOfClass:[PKTCategoryOption class]]) {
    dict = @{@"value" : @(option.optionID)};
  } else if ([self.unboxedValue isKindOfClass:[NSNumber class]]) {
    dict = @{@"value" : self.unboxedValue};
  }
  
  return dict;
}

+ (NSArray *)unboxedValueClasses {
  return @[[PKTCategoryOption class], [NSNumber class]];
}

@end
