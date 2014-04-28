//
//  PKTDateItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateItemFieldValue.h"

static NSDateFormatter *sFormatter = nil;

@implementation PKTDateItemFieldValue

+ (void)initialize {
  if (self == [PKTDateItemFieldValue class]) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sFormatter = [[NSDateFormatter alloc] init];
      sFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
      sFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
      sFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
    });
  }
}

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  self.startDate = [[self class] dateFromString:valueDictionary[@"start"]];
  self.endDate = [[self class] dateFromString:valueDictionary[@"end"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"start" : [[self class] stringFromDate:self.startDate],
           @"end" : [[self class] stringFromDate:self.endDate]};
}

#pragma mark - Private

+ (NSDate *)dateFromString:(NSString *)dateString {
  return [sFormatter dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date {
  return [sFormatter stringFromDate:date];
}

@end
