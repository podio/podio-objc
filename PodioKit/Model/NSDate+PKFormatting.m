//
//  NSDate+PKFormatting.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSDate+PKFormatting.h"

@implementation NSDate (PKFormatting)

+ (NSDate *)pk_dateFromUTCDateTimeString:(NSString *)dateTimeString {
  return [[self UTCDateTimeFormatter] dateFromString:dateTimeString];
}

+ (NSDate *)pk_dateFromUTCDateString:(NSString *)dateString {
  return [[self UTCDateFormatter] dateFromString:dateString];
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

+ (NSDateFormatter *)UTCFormatterWithDateFormat:(NSString *)format {
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.dateFormat = format;
  
  return formatter;
}

@end
