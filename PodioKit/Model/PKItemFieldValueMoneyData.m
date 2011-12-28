//
//  POTransformableMoneyData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueMoneyData.h"


static NSString * const POTransformableMoneyDataAmountKey = @"Amount";
static NSString * const POTransformableMoneyDataCurrencyKey = @"Currency";

@implementation PKItemFieldValueMoneyData

@synthesize amount = amount_;
@synthesize currency = currency_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    amount_ = [[aDecoder decodeObjectForKey:POTransformableMoneyDataAmountKey] copy];
    currency_ = [[aDecoder decodeObjectForKey:POTransformableMoneyDataCurrencyKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:amount_ forKey:POTransformableMoneyDataAmountKey];
  [aCoder encodeObject:currency_ forKey:POTransformableMoneyDataCurrencyKey];
}

- (void)dealloc {
  [amount_ release];
  [currency_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueMoneyData *data = [self data];
  
  data.amount = [NSNumber numberWithFloat:[[dict pk_objectForKey:@"value"] floatValue]];
  data.currency = [dict pk_objectForKey:@"currency"];
  
  return data;
}

@end
