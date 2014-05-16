//
//  PKTMoneyItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMoneyItemFieldValue.h"
#import "PKTMoney.h"

static NSString * const kValueKey = @"value";
static NSString * const kCurrencyKey = @"currency";

@implementation PKTMoneyItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTMoney alloc] initWithDictionary:valueDictionary];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTMoney *money = self.unboxedValue;
  
  return @{kValueKey : money.amount,
           kCurrencyKey : money.currency};
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return [value isKindOfClass:[PKTMoney class]];
}

@end
