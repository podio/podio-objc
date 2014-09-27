//
//  PKTDateRangeTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTDateRange.h"

@interface PKTDateRangeTests : XCTestCase

@end

@implementation PKTDateRangeTests

- (void)testMissingTimeComponentsFromDictionary {
  NSDictionary *dateDict = @{
    @"start_date_utc" : @"2014-07-14",
    @"end" : @"2014-07-16 00:00:00",
    @"end_date" : @"2014-07-16",
    @"end_date_utc" : @"2014-07-16",
    @"start_time_utc" : [NSNull null],
    @"start_time" : [NSNull null],
    @"start_date" : @"2014-07-14",
    @"start" : @"2014-07-14 00:00:00",
    @"end_time" : [NSNull null],
    @"end_time_utc" : [NSNull null],
    @"end_utc" : @"2014-07-16",
    @"start_utc" : @"2014-07-14",
  };
  
  PKTDateRange *range = [[PKTDateRange alloc] initWithDictionary:dateDict];
  expect(range.startDate).toNot.beNil();
  expect(range.endDate).toNot.beNil();
  expect(range.includesTimeComponent).to.beFalsy();
}

- (void)testHasTimeComponentsFromDictionary {
  NSDictionary *dateDict = @{
    @"start_date_utc" : @"2014-07-14",
    @"end" : @"2014-07-15 16:00:00",
    @"end_date" : @"2014-07-15",
    @"end_date_utc" : @"2014-07-15",
    @"start_time_utc" : @"13:00:00",
    @"start_time" : @"15:00:00",
    @"start_date" : @"2014-07-14",
    @"start" : @"2014-07-14 15:00:00",
    @"end_time" : @"16:00:00",
    @"end_time_utc" : @"14:00:00",
    @"end_utc" : @"2014-07-15 14:00:00",
    @"start_utc" : @"2014-07-14 13:00:00"
  };
  
  PKTDateRange *range = [[PKTDateRange alloc] initWithDictionary:dateDict];
  expect(range.startDate).toNot.beNil();
  expect(range.endDate).toNot.beNil();
  expect(range.includesTimeComponent).to.beTruthy();
}

@end
