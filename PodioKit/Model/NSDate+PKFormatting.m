//
//  NSDate+PKFormatting.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSDate+PKFormatting.h"

@implementation NSDate (PKFormatting)

#pragma mark  - Public

+ (NSDate *)pk_dateFromLocalDateTimeString:(NSString *)dateTimeString {
  return [[self localDateTimeFormatter] dateFromString:dateTimeString];
}

+ (NSDate *)pk_dateFromLocalDateString:(NSString *)dateString {
  return [[self localDateFormatter] dateFromString:dateString];
}

+ (NSDate *)pk_dateFromUTCDateTimeString:(NSString *)dateTimeString {
  return [[self UTCDateTimeFormatter] dateFromString:dateTimeString];
}

+ (NSDate *)pk_dateFromUTCDateString:(NSString *)dateString {
  return [[self UTCDateFormatter] dateFromString:dateString];
}

- (NSString *)pk_localDateTimeString {
  return [[[self class] localDateTimeFormatter] stringFromDate:self];
}

- (NSString *)pk_localDateString {
  return [[[self class] localDateFormatter] stringFromDate:self];
}

- (NSString *)pk_localTimeString {
  return [[[self class] localTimeFormatter] stringFromDate:self];
}

- (NSString *)pk_UTCDateTimeString {
  return [[[self class] UTCDateTimeFormatter] stringFromDate:self];
}

- (NSString *)pk_UTCDateString {
  return [[[self class] UTCDateFormatter] stringFromDate:self];
}

- (NSString *)pk_UTCTimeString {
  return [[[self class] UTCTimeFormatter] stringFromDate:self];
}

#pragma mark - Private

+ (NSDateFormatter *)UTCDateTimeFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    formatter = [self UTCFormatterWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  });
  
  return formatter;
}

+ (NSDateFormatter *)UTCDateFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    formatter = [self UTCFormatterWithDateFormat:@"yyyy-MM-dd"];
  });
  
  return formatter;
}

+ (NSDateFormatter *)UTCTimeFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    formatter = [self UTCFormatterWithDateFormat:@"HH:mm:ss"];
  });
  
  return formatter;
}

+ (NSDateFormatter *)localDateTimeFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    formatter = [self localFormatterWithDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  });
  
  return formatter;
}

+ (NSDateFormatter *)localDateFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    formatter = [self localFormatterWithDateFormat:@"yyyy-MM-dd"];
  });
  
  return formatter;
}

+ (NSDateFormatter *)localTimeFormatter {
  static NSDateFormatter *formatter = nil;
  
  static dispatch_once_t once;
  dispatch_once(&once, ^{
    formatter = [self localFormatterWithDateFormat:@"HH:mm:ss"];
  });
  
  return formatter;
}

#pragma mark - Private

+ (NSDateFormatter *)UTCFormatterWithDateFormat:(NSString *)format {
  return [self UTCFormatterWithTimeZone:[NSTimeZone timeZoneWithName:@"UTC"] dateFormat:format];
}

+ (NSDateFormatter *)localFormatterWithDateFormat:(NSString *)format {
  return [self UTCFormatterWithTimeZone:nil dateFormat:format];
}

+ (NSDateFormatter *)UTCFormatterWithTimeZone:(NSTimeZone *)timeZone dateFormat:(NSString *)format {
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.dateFormat = format;
  
  if (timeZone) {
    formatter.timeZone = timeZone;
  }
  
  return formatter;
}

@end
