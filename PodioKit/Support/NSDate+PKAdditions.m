//
//  NSDate+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSDate+PKAdditions.h"

@implementation NSDate (PKAdditions)

- (NSDate *)pk_convertedDateInCurrentCalendarToCurrentTimeZoneFromUTC {
  return [self pk_convertedDateInCalendar:[NSCalendar currentCalendar]
                             fromTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]
                               toTimeZone:[NSTimeZone localTimeZone]];
}

- (NSDate *)pk_convertedDateInCurrentCalendarToUTCFromCurrentTimeZone {
  return [self pk_convertedDateInCalendar:[NSCalendar currentCalendar]
                             fromTimeZone:[NSTimeZone localTimeZone]
                               toTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
}

- (NSDate *)pk_convertedDateInCalendar:(NSCalendar *)calendar fromTimeZone:(NSTimeZone *)fromTimeZone toTimeZone:(NSTimeZone *)toTimeZone {
  NSCalendar *cal = [calendar copy];
  cal.timeZone = fromTimeZone;
  NSDateComponents *comps = [cal components:(NSCalendarUnitYear |
                                             NSCalendarUnitMonth |
                                             NSCalendarUnitDay |
                                             NSCalendarUnitHour |
                                             NSCalendarUnitMinute |
                                             NSCalendarUnitSecond) fromDate:self];
  cal.timeZone = toTimeZone;
  
  return [cal dateFromComponents:comps];
}

@end
