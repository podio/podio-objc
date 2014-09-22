//
//  NSDate+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSDate+PKAdditions.h"

@implementation NSDate (PKAdditions)

+ (NSDate *)pk_dateWithString:(NSString *)dateString formatString:(NSString *)formatString {
  if (dateString == nil || formatString == nil) {
    return nil;
  }
  
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatString];
  
  // Need to use a specific locale to parse format string correctly
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  [formatter setLocale:locale];
	
	NSDate *date = [formatter dateFromString:dateString];
  
	return date;
}

+ (NSDate *)pk_dateWithDateString:(NSString*)dateString {
	return [[self class] pk_dateWithString:dateString formatString:@"yyyy-MM-dd"];
}

+ (NSDate *)pk_dateWithDateTimeString:(NSString*)dateString {
	return [[self class] pk_dateWithString:dateString formatString:@"yyyy-MM-dd HH:mm:ss"];
}

+ (NSDate *)pk_localDateFromUTCDateString:(NSString *)dateString {
  return [[NSDate pk_dateWithDateTimeString:dateString] pk_localDateFromUTCDate];
}

- (NSDate *)pk_localDateFromUTCDate {
	NSTimeZone* sourceTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
	NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
	
	NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
	NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
	
	return [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
}

- (NSDate *)pk_UTCDateFromLocalDate {
	NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
	NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
	
	NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
	NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
	
	return [[NSDate alloc] initWithTimeInterval:interval sinceDate:self];
}

- (NSString *)pk_dateTimeStringWithFormatString:(NSString *)formatString {
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatString];
  
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  [formatter setLocale:locale];
	
	NSString *dateTimeString = [formatter stringFromDate:self];
  
	return dateTimeString;
}

- (NSString *)pk_dateString {
	return [self pk_dateTimeStringWithFormatString:@"YYYY-MM-dd"];
}

- (NSString *)pk_timeString {
	return [self pk_dateTimeStringWithFormatString:@"HH:mm:ss"];
}

- (NSString *)pk_dateTimeString {
  return [self pk_dateTimeStringWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
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
  NSCalendar *cal = [calendar copy];
  cal.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  
  NSDateComponents *comps = [cal components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
  comps.hour = 23;
  comps.minute = 59;
  comps.second = 59;
  
  return [cal dateFromComponents:comps];
}

@end
