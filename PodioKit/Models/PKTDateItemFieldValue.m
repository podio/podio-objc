//
//  PKTDateItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateItemFieldValue.h"

static NSString * const kStartDateKey = @"start";
static NSString * const kEndDateKey = @"end";

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
  
  self.startDate = [[self class] dateFromString:valueDictionary[kStartDateKey]];
  self.endDate = [[self class] dateFromString:valueDictionary[kEndDateKey]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{kStartDateKey : [[self class] stringFromDate:self.startDate],
           kEndDateKey : [[self class] stringFromDate:self.endDate]};
}

- (void)setUnboxedValue:(id)unboxedValue {
  NSAssert([unboxedValue isKindOfClass:[NSDictionary class]], @"The unboxed value for date value needs to be an NSDictionary.");
  NSParameterAssert(unboxedValue[kStartDateKey]);
  NSParameterAssert(unboxedValue[kEndDateKey]);
  
  self.startDate = unboxedValue[kStartDateKey];
  self.endDate =unboxedValue[kEndDateKey];
}

- (id)unboxedValue {
  return @{kStartDateKey : self.startDate,
           kEndDateKey : self.endDate};
}

#pragma mark - Private

+ (NSDate *)dateFromString:(NSString *)dateString {
  return [sFormatter dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date {
  return [sFormatter stringFromDate:date];
}

@end
