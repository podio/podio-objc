//
//  NSDate+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKAdditions)

+ (NSDate *)pk_dateWithString:(NSString *)dateString formatString:(NSString *)formatString;

+ (NSDate *)pk_dateWithDateString:(NSString*)dateString;

+ (NSDate *)pk_dateWithDateTimeString:(NSString*)dateString;

+ (NSDate *)pk_localDateFromUTCDateString:(NSString *)dateString;

- (NSDate *)pk_localDateFromUTCDate;

- (NSDate *)pk_UTCDateFromLocalDate;

- (NSString *)pk_dateTimeStringWithFormatString:(NSString *)formatString;

- (NSString *)pk_dateString;
- (NSString *)pk_timeString;
- (NSString *)pk_dateTimeString;

- (BOOL)pk_isLastMinuteOfDayInUTCForCalendar:(NSCalendar *)calendar;
- (NSDate *)pk_dateWithLastMinuteOfDayInUTCForCalendar:(NSCalendar *)calendar;

@end
