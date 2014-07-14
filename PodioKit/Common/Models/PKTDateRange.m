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
  _includesStartDateTimeComponent = YES;
  _includesEndDateTimeComponent = YES;
  
  return self;
}

+ (instancetype)rangeWithStartDate:(NSDate *)startDate {
  return [[self alloc] initWithStartDate:startDate endDate:nil];
}

+ (instancetype)rangeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  return [[self alloc] initWithStartDate:startDate endDate:endDate];
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"startDate" : @"start_utc",
           @"endDate" : @"end_utc",
           @"includesStartDateTimeComponent" : @"start_time_utc",
           @"includesEndDateTimeComponent" : @"end_time_utc"
           };
}

+ (NSValueTransformer *)startDateValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)endDateValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)includesStartDateTimeComponentValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSString *timeString) {
    return @(timeString != nil);
  }];
}

+ (NSValueTransformer *)includesEndDateTimeComponentValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSString *timeString) {
    return @(timeString != nil);
  }];
}

@end
