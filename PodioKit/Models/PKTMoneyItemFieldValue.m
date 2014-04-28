//
//  PKTMoneyItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMoneyItemFieldValue.h"

@implementation PKTMoneyItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _value = [valueDictionary[@"value"] copy];
  _currency = [valueDictionary[@"currency"] copy];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : self.value,
           @"currency" : self.currency};
}

@end
