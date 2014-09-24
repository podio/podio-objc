//
//  NSDate+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSDate+PKAdditions.h"

@implementation NSDate (PKAdditions)

- (BOOL)pk_isLastMinuteOfDayInUTCForCurrentCalendar {
  return [self pk_isLastMinuteOfDayInUTCForCalendar:[NSCalendar currentCalendar]];
}

- (NSDate *)pk_dateWithLastMinuteOfDayInUTCForCurrentCalendar {
  return [self pk_dateWithLastMinuteOfDayInUTCForCalendar:[NSCalendar currentCalendar]];
}

- (BOOL)pk_isLastMinuteOfDayInUTCForCalendar:(NSCalendar *)calendar {
  // Check if UTC components are the last minute of the hour. This was used in legacy date handling
  // in the Podio API to indicate to ignore the time component
  NSCalendar *cal = [calendar copy];
  cal.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  
  NSDateComponents *comps = [cal components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
  BOOL isLastMinute = comps.hour == 23 && comps.minute == 59;
  
  return isLastMinute;
}

- (NSDate *)pk_dateWithLastMinuteOfDayInUTCForCalendar:(NSCalendar *)calendar {
  NSDateComponents *comps = [calendar components:(NSYearCalendarUnit |
                                                  NSMonthCalendarUnit |
                                                  NSDayCalendarUnit |
                                                  NSHourCalendarUnit |
                                                  NSMinuteCalendarUnit |
                                                  NSSecondCalendarUnit) fromDate:self];
  
  // Update components to reflect the last minute/second of the day
  comps.hour = 23;
  comps.minute = 59;
  comps.second = 59;
  
  // Create a new date in UTC
  NSCalendar *cal = [calendar copy];
  cal.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  
  return [cal dateFromComponents:comps];
}

- (NSDate *)pk_convertedDateInCurrentCalendarToCurrentTimeZoneFromUTC {
  return [self pk_convertedDateInCalendar:[NSCalendar currentCalendar]
                             fromTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]
                               toTimeZone:[NSTimeZone localTimeZone]];
}

- (NSDate *)pk_convertedDateInCalendar:(NSCalendar *)calendar fromTimeZone:(NSTimeZone *)fromTimeZone toTimeZone:(NSTimeZone *)toTimeZone {
  NSCalendar *cal = [calendar copy];
  cal.timeZone = fromTimeZone;
  NSDateComponents *comps = [cal components:(NSYearCalendarUnit |
                                             NSMonthCalendarUnit |
                                             NSDayCalendarUnit |
                                             NSHourCalendarUnit |
                                             NSMinuteCalendarUnit |
                                             NSSecondCalendarUnit) fromDate:self];
  cal.timeZone = toTimeZone;
  
  return [cal dateFromComponents:comps];
}

@end
