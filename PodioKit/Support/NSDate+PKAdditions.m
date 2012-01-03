//
//  NSDate+POAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright 2011 Podio. All rights reserved.
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
  [locale release];
	
	NSDate *date = [formatter dateFromString:dateString];
	[formatter release];
  
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
	
	return [[[NSDate alloc] initWithTimeInterval:interval sinceDate:self] autorelease];
}

- (NSDate *)pk_UTCDateFromLocalDate {
	NSTimeZone* sourceTimeZone = [NSTimeZone systemTimeZone];
	NSTimeZone* destinationTimeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
	
	NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:self];
	NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:self];
	NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
	
	return [[[NSDate alloc] initWithTimeInterval:interval sinceDate:self] autorelease];
}

- (NSString *)pk_dateTimeStringWithFormatString:(NSString *)formatString {
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:formatString];
  
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  [formatter setLocale:locale];
  [locale release];
	
	NSString *dateTimeString = [formatter stringFromDate:self];
	[formatter release];
  
	return dateTimeString;
}

- (NSString *)pk_dateString {
	return [self pk_dateTimeStringWithFormatString:@"YYYY-MM-dd"];
}

- (NSString *)pk_dateTimeString {
  return [self pk_dateTimeStringWithFormatString:@"yyyy-MM-dd HH:mm:ss"];
}

@end
