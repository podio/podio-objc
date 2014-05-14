//
//  PKTDateRange.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateRange.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTDateRange

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  self = [super init];
  if (!self) return nil;
  
  _startDate = [startDate copy];
  _endDate = [endDate copy];
  
  return self;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"startDate" : @"start",
           @"endDate" : @"end",
           };
}

+ (NSValueTransformer *)startDateValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)endDateValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

@end
