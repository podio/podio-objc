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
  
  return location.fullDescription ? @{@"value" : [location fullDescription]} : nil;
}

+ (Class)unboxedValueClass {
  return [PKTLocation class];
}

@end
