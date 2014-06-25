//
//  NSDateFormatter+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSDateFormatter+PKTAdditions.h"

@implementation NSDateFormatter (PKTAdditions)

+ (NSDateFormatter *)pkt_UTCDateFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd";
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
  
  return formatter;
}

+ (NSDateFormatter *)pkt_UTCDateTimeFormatter {
  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
  formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];
  
  return formatter;
}

@end
