//
//  POAppFieldMoneyData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/22/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAppFieldMoneyData.h"


static NSString * const POAppFieldCategoryDataAllowedCurrenciesKey = @"AllowedCurrencies";

@implementation PKAppFieldMoneyData

@synthesize allowedCurrencies = allowedCurrencies_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    allowedCurrencies_ = [[aDecoder decodeObjectForKey:POAppFieldCategoryDataAllowedCurrenciesKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:allowedCurrencies_ forKey:POAppFieldCategoryDataAllowedCurrenciesKey];
}

- (void)dealloc {
  [allowedCurrencies_ release];
  [super dealloc];
}

@end
