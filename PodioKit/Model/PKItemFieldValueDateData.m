//
//  POTransformableDateData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueDateData.h"
#import "NSDate+PKAdditions.h"

static NSString * const POTransformableDateDataStartDateKey = @"StartDate";
static NSString * const POTransformableDateDataEndDateKey = @"EndDate";

@implementation PKItemFieldValueDateData

@synthesize startDate = startDate_;
@synthesize endDate = endDate_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    startDate_ = [[aDecoder decodeObjectForKey:POTransformableDateDataStartDateKey] copy];
    endDate_ = [[aDecoder decodeObjectForKey:POTransformableDateDataEndDateKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:startDate_ forKey:POTransformableDateDataStartDateKey];
  [aCoder encodeObject:endDate_ forKey:POTransformableDateDataEndDateKey];
}

- (void)dealloc {
  [startDate_ release];
  [endDate_ release];
  [super dealloc];
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
