//
//  PKTContactItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTContactItemFieldValue.h"
#import "PKTProfile.h"

@implementation PKTContactItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _profile = [[PKTProfile alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : @(self.profile.profileID)};
}

@end
