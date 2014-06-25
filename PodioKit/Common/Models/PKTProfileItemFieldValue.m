//
//  PKTProfileItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTProfileItemFieldValue.h"
#import "PKTProfile.h"

@implementation PKTProfileItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTProfile alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTProfile *profile = self.unboxedValue;
  
  return @{@"value" : @(profile.profileID)};
}

+ (Class)unboxedValueClass {
  return [PKTProfile class];
}

@end
