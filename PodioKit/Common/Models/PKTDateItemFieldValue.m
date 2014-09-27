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

static NSString * const kStartKey = @"start_utc";
static NSString * const kEndKey = @"end_utc";
static NSString * const kStartDateKey = @"start_date_utc";
static NSString * const kEndDateKey = @"end_date_utc";
static NSString * const kStartTimeKey = @"start_time_utc";
static NSString * const kEndTimeKey = @"end_time_utc";

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
  
  if (dateRange.includesTimeComponent) {
    // Simply format as UTC dates
    if (dateRange.startDate) {
      mutDict[kStartKey] = [dateRange.startDate pkt_UTCDateTimeString];
    }
    if (dateRange.endDate) {
      mutDict[kEndKey] = [dateRange.endDate pkt_UTCDateTimeString];
    }
  } else {
    // If there is no time component, consider the date to be passed
    // to be the day component of the NSDate in UTC
    if (dateRange.startDate) {
      mutDict[kStartDateKey] = [dateRange.startDate pkt_UTCDateString];
      mutDict[kStartTimeKey] = [NSNull null];
    }
    
    if (dateRange.endDate) {
      mutDict[kEndDateKey] = [dateRange.endDate pkt_UTCDateString];
      mutDict[kEndTimeKey] = [NSNull null];
    }
  }

  return [mutDict copy];
}

+ (Class)unboxedValueClass {
  return [PKTDateRange class];
}

@end
