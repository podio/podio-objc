//
//  PKTMoney.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMoney.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTMoney

- (instancetype)initWithAmount:(NSNumber *)amount currency:(NSString *)currency {
  self = [super init];
  if (!self) return nil;
  
  _amount = [amount copy];
  _currency = [currency copy];
  
  return self;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"amount" : @"value",
           @"currency" : @"currency"
           };
}

+ (NSValueTransformer *)amountValueTransformer {
  return [NSValueTransformer pkt_numberValueTransformer];
}

@end
