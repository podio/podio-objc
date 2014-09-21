//
//  PKDate+Formatting.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKDate+PKFormatting.h"

@implementation PKDate (PKFormatting)

#pragma mark - Public

- (NSString *)pk_UTCDateTimeString {
  NSDateFormatter *formatter = self.includesTimeComponent ?
    [[self class] UTCDateTimeFormatter] :
    [[self class] UTCDateFormatter];
  
  return [formatter stringFromDate:self.date];
}

- (NSString *)pk_UTCDateString {
  return [[[self class] UTCDateFormatter] stringFromDate:self.date];
}

- (NSString *)pk_UTCTimeString {
  if (!self.includesTimeComponent) return nil;
  
  return [[[self class] UTCTimeFormatter] stringFromDate:self.date];
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
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.dateFormat = format;
  
  return formatter;
}

@end
