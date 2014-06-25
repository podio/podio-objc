//
//  PKTDateItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateItemFieldValue.h"
#import "PKTDateRange.h"
#import "NSDate+PKTAdditions.h"

static NSString * const kStartDateKey = @"start_utc";
static NSString * const kEndDateKey = @"end_utc";

@implementation PKTDateItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTDateRange alloc] initWithDictionary:valueDictionary];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTDateRange *dateRange = self.unboxedValue;

  NSMutableDictionary *mutDict = [NSMutableDictionary new];
  
  if (dateRange.startDate) {
      mutDict[kStartDateKey] = [dateRange.startDate pkt_UTCDateTimeString];
  }

  if (dateRange.endDate) {
    mutDict[kEndDateKey] = [dateRange.endDate pkt_UTCDateTimeString];
  }

  return [mutDict copy];
}

+ (Class)unboxedValueClass {
  return [PKTDateRange class];
}

@end
