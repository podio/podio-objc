//
//  NSDate+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSDate+PKTAdditions.h"
#import "NSDateFormatter+PKTAdditions.h"

static NSDateFormatter *sUTCDateFormatter = nil;
static NSDateFormatter *sUTCDateTimeFormatter = nil;

@implementation NSDate (PKTAdditions)

#pragma mark - Public

+ (NSDate *)pkt_dateFromUTCDateString:(NSString *)dateString {
  return [[self UTCDateFormatter] dateFromString:dateString];
}

+ (NSDate *)pkt_dateFromUTCDateTimeString:(NSString *)dateTimeString {
  return [[self UTCDateTimeFormatter] dateFromString:dateTimeString];
}

- (NSString *)pkt_UTCDateString {
  return [[[self class] UTCDateFormatter] stringFromDate:self];
}

- (NSString *)pkt_UTCDateTimeString {
  return [[[self class] UTCDateTimeFormatter] stringFromDate:self];
}

#pragma mark - Private

+ (NSDateFormatter *)UTCDateFormatter {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sUTCDateFormatter = [NSDateFormatter pkt_UTCDateFormatter];
  });
  
  return sUTCDateFormatter;
}

+ (NSDateFormatter *)UTCDateTimeFormatter {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    sUTCDateTimeFormatter = [NSDateFormatter pkt_UTCDateTimeFormatter];
  });
  
  return sUTCDateTimeFormatter;
}

@end
