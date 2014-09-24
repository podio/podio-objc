//
//  NSDate+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKAdditions)

- (BOOL)pk_isLastMinuteOfDayInUTCForCurrentCalendar;

- (NSDate *)pk_dateWithLastMinuteOfDayInUTCForCurrentCalendar;

- (BOOL)pk_isLastMinuteOfDayInUTCForCalendar:(NSCalendar *)calendar;

- (NSDate *)pk_dateWithLastMinuteOfDayInUTCForCalendar:(NSCalendar *)calendar;

- (NSDate *)pk_convertedDateInCurrentCalendarToCurrentTimeZoneFromUTC;

- (NSDate *)pk_convertedDateInCalendar:(NSCalendar *)calendar fromTimeZone:(NSTimeZone *)fromTimeZone toTimeZone:(NSTimeZone *)toTimeZone;

@end
