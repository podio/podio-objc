//
//  PKItemFieldValueDateData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueDateData.h"
#import "NSDate+PKAdditions.h"

static NSString * const PKItemFieldValueDateDataStartDateKey = @"StartDate";
static NSString * const PKItemFieldValueDateDataEndDateKey = @"EndDate";

@implementation PKItemFieldValueDateData

@synthesize startDate = startDate_;
@synthesize endDate = endDate_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    startDate_ = [[aDecoder decodeObjectForKey:PKItemFieldValueDateDataStartDateKey] copy];
    endDate_ = [[aDecoder decodeObjectForKey:PKItemFieldValueDateDataEndDateKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:startDate_ forKey:PKItemFieldValueDateDataStartDateKey];
  [aCoder encodeObject:endDate_ forKey:PKItemFieldValueDateDataEndDateKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueDateData *data = [self data];
  
  data.startDate = [NSDate pk_dateWithDateTimeString:[dict pk_objectForKey:@"start"]];
  
  NSString *endDateString = [dict pk_objectForKey:@"end"];
  if (endDateString) {
    data.endDate = [NSDate pk_dateWithDateTimeString:endDateString];
  }
  
  return data;
}

@end
