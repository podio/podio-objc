//
//  PKTMoneyItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMoneyItemFieldValue.h"

static NSString * const kValueKey = @"value";
static NSString * const kCurrencyKey = @"currency";

@implementation PKTMoneyItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _value = [valueDictionary[kValueKey] copy];
  _currency = [valueDictionary[kCurrencyKey] copy];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{kValueKey : self.value,
           kCurrencyKey : self.currency};
}

- (void)setUnboxedValue:(id)unboxedValue {
  NSAssert([unboxedValue isKindOfClass:[NSDictionary class]], @"The unboxed value for money value needs to be an NSDictionary.");
  NSParameterAssert(unboxedValue[kValueKey]);
  NSParameterAssert(unboxedValue[kCurrencyKey]);
  
  self.value = unboxedValue[kValueKey];
  self.currency =unboxedValue[kCurrencyKey];
}

- (id)unboxedValue {
  return @{kValueKey : self.value,
           kCurrencyKey : self.currency};
}

@end
