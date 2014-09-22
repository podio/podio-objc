//
//  PKDate+NSDate.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit/PodioKit.h>

@interface PKDate (NSDate)

+ (instancetype)dateForCurrentCalendarWithDate:(NSDate *)date;

- (NSDate *)dateForCurrentCalendar;

+ (instancetype)dateWithDate:(NSDate *)date withoutTimeIfLastMinuteOfDayForCalendar:(NSCalendar *)calendar;

- (NSDate *)dateWithoutTimeIfLastMinuteOfDayForCalendar:(NSCalendar *)calendar;

@end
