//
//  PKDateTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 24/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PKDate.h"

static NSTimeInterval const kSecondsInHour = 60 * 60;

@interface PKDateTests : SenTestCase

@end

@implementation PKDateTests

- (void)testDatesWithDifferentTimesShouldNotBeEqual {
  PKDate *date1 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:kSecondsInHour] includesTimeComponent:YES];
  PKDate *date2 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:23 * kSecondsInHour] includesTimeComponent:YES];
  expect(date1).toNot.equal(date2);
}

- (void)testDatesWithoutTimeOnSameDayShouldBeEqual {
  PKDate *date1 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:kSecondsInHour] includesTimeComponent:NO];
  PKDate *date2 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:23 * kSecondsInHour] includesTimeComponent:NO];
  expect(date1).to.equal(date2);
}

- (void)testDatesWithoutTimeOnDifferentDaysShouldNotBeEqual {
  PKDate *date1 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:kSecondsInHour] includesTimeComponent:NO];
  PKDate *date2 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:25 * kSecondsInHour] includesTimeComponent:NO];
  expect(date1).toNot.equal(date2);
}

- (void)testDatesWithMixedTimesShouldNotBeEqual {
  PKDate *date1 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:kSecondsInHour] includesTimeComponent:NO];
  PKDate *date2 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:23 * kSecondsInHour] includesTimeComponent:YES];
  expect(date1).toNot.equal(date2);
}

- (void)testDateStringWithTime {
  PKDate *date1 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:5 * kSecondsInHour] includesTimeComponent:YES];
  PKDate *date2 = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:5 * kSecondsInHour] includesTimeComponent:NO];
  expect([date1 pk_UTCDateTimeString]).to.equal(@"1970-01-01 05:00:00");
  expect([date2 pk_UTCDateTimeString]).to.equal(@"1970-01-01 00:00:00");
}

@end
