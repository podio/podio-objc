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
  self = [super init];
  if (!self) return nil;
  
  _profile = [[PKTProfile alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : @(self.profile.profileID)};
}

- (void)setUnboxedValue:(id)unboxedValue {
  NSAssert([unboxedValue isKindOfClass:[PKTProfile class]], @"The unboxed value for profile value needs to be a PKTProfile.");
  self.profile = unboxedValue;
}

- (id)unboxedValue {
  return self.profile;
}

@end
