//
//  PKTLocationItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTLocationItemFieldValue.h"
#import "PKTLocation.h"

@implementation PKTLocationItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initFromValueDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTLocation alloc] initWithDictionary:valueDictionary];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTLocation *location = self.unboxedValue;
  
  NSDictionary *dict = nil;
  if (location.value) {
    dict = @{@"value" : location.value};
  } else if (location.latitude > DBL_EPSILON && location.longitude > DBL_EPSILON) {
    dict = @{@"lat" : @(location.latitude),
             @"lng" : @(location.longitude)};
  }
  
  return dict;
}

+ (Class)unboxedValueClass {
  return [PKTLocation class];
}

@end
