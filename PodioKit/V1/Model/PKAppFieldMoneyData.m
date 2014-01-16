//
//  PKAppFieldMoneyData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/22/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAppFieldMoneyData.h"


static NSString * const PKAppFieldMoneyDataAllowedCurrenciesKey = @"AllowedCurrencies";

@implementation PKAppFieldMoneyData

@synthesize allowedCurrencies = allowedCurrencies_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    allowedCurrencies_ = [[aDecoder decodeObjectForKey:PKAppFieldMoneyDataAllowedCurrenciesKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:allowedCurrencies_ forKey:PKAppFieldMoneyDataAllowedCurrenciesKey];
}


@end
