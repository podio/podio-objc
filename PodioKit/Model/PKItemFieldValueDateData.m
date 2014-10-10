//
//  PKItemFieldValueDateData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueDateData.h"
#import "NSDate+PKFormatting.h"
#import "PKDate.h"

static NSString * const PKItemFieldValueDateDataStartDateKey = @"StartDate2";
static NSString * const PKItemFieldValueDateDataEndDateKey = @"EndDate2";

@implementation PKItemFieldValueDateData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _startDate = [[aDecoder decodeObjectForKey:PKItemFieldValueDateDataStartDateKey] copy];
    _endDate = [[aDecoder decodeObjectForKey:PKItemFieldValueDateDataEndDateKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:_startDate forKey:PKItemFieldValueDateDataStartDateKey];
  [aCoder encodeObject:_endDate forKey:PKItemFieldValueDateDataEndDateKey];
}

- (NSDictionary *)valueDictionary {
  NSMutableDictionary *values = [NSMutableDictionary new];
  
  if (self.startDate.includesTimeComponent) {
    if (self.startDate) {
      values[@"start_utc"] = [self.startDate pk_UTCDateTimeString];
    }
    
    if (self.endDate) {
      values[@"end_utc"] = [self.endDate pk_UTCDateTimeString];
    }
  } else {
    if (self.startDate) {
      values[@"start_date"] = [self.startDate pk_UTCDateString];
      values[@"start_time_utc"] = [NSNull null];
    }
    
    if (self.endDate) {
      values[@"end_date"] = [self.endDate pk_UTCDateString];
      values[@"end_time_utc"] = [NSNull null];
    }
  }
  
  return [values copy];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueDateData *data = [self data];
  
  BOOL hasTimeComponent = [dict pk_objectForKey:@"start_time_utc"] != nil;
  if (hasTimeComponent) {
    NSDate *startDate = [NSDate pk_dateFromUTCDateTimeString:[dict pk_objectForKey:@"start_utc"]];
    NSDate *endDate = [NSDate pk_dateFromUTCDateTimeString:[dict pk_objectForKey:@"end_utc"]];
    
    if (startDate) {
      data.startDate = [PKDate dateWithDate:startDate includesTimeComponent:YES];
    }
    
    if (endDate) {
      data.endDate = [PKDate dateWithDate:endDate includesTimeComponent:YES];
    }
  } else {
    NSDate *startDate = [NSDate pk_dateFromUTCDateString:[dict pk_objectForKey:@"start_date"]];
    NSDate *endDate = [NSDate pk_dateFromUTCDateString:[dict pk_objectForKey:@"end_date"]];
    
    if (startDate) {
      data.startDate = [PKDate dateWithDate:startDate includesTimeComponent:NO];
    }
    
    if (endDate) {
      data.endDate = [PKDate dateWithDate:endDate includesTimeComponent:NO];
    }
  }
  
  return data;
}

@end
