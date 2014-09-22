//
//  PKDate+NSDateTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PKDate+NSDate.h"

@interface PKDate_NSDateTests : SenTestCase

@end

@implementation PKDate_NSDateTests

- (void)testDateWithTime {
  NSDate *date = [self dateWithString:@"2014-09-22 18:59:59"];
  PKDate *date2 = [PKDate dateForCurrentCalendarWithDate:date];
  expect(date2.includesTimeComponent).to.beTruthy();
}

- (void)testDateWithoutTime {
  NSDate *date = [self dateWithString:@"2014-09-22 23:59:59"];
  PKDate *date2 = [PKDate dateForCurrentCalendarWithDate:date];
  expect(date2.includesTimeComponent).to.beFalsy();
}

- (NSDate *)dateWithString:(NSString *)dateString {
  NSDateFormatter *formatter = [NSDateFormatter new];
  formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
  formatter.timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  
  return [formatter dateFromString:dateString];
}

@end
