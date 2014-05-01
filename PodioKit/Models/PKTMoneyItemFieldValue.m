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
  self.value = unboxedValue[kValueKey];
  self.currency =unboxedValue[kCurrencyKey];
}

- (id)unboxedValue {
  return @{kValueKey : self.value,
           kCurrencyKey : self.currency};
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return [value isKindOfClass:[NSDictionary class]] &&
    [value[kValueKey] isKindOfClass:[NSNumber class]] &&
    [value[kCurrencyKey] isKindOfClass:[NSString class]];
}

@end
