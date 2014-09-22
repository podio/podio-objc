//
//  PKDate+NSDate.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKDate+NSDate.h"
#import "NSDate+PKAdditions.h"

@implementation PKDate (NSDate)

+ (instancetype)dateForCurrentCalendarWithDate:(NSDate *)date {
  return [self dateWithDate:date withoutTimeIfLastMinuteOfDayForCalendar:[NSCalendar currentCalendar]];
}

- (NSDate *)dateForCurrentCalendar {
  return [self dateWithoutTimeIfLastMinuteOfDayForCalendar:[NSCalendar currentCalendar]];
}

+ (instancetype)dateWithDate:(NSDate *)date withoutTimeIfLastMinuteOfDayForCalendar:(NSCalendar *)calendar {
  BOOL includesTimeComponent = ![date pk_isLastMinuteOfDayInUTCForCalendar:calendar];
  return [self dateWithDate:date includesTimeComponent:includesTimeComponent];
}

- (NSDate *)dateWithoutTimeIfLastMinuteOfDayForCalendar:(NSCalendar *)calendar {
  return self.includesTimeComponent ? self.date : [self.date pk_dateWithLastMinuteOfDayInUTCForCalendar:calendar];
}

@end
