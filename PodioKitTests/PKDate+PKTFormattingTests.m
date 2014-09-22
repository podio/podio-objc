//
//  PKDate+PKTFormattingTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "PKDate.h"
#import "PKDate+PKFormatting.h"

@interface PKDate_PKTFormattingTests : SenTestCase

@end

@implementation PKDate_PKTFormattingTests

- (void)testDateTimeString {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:YES];
  expect([date pk_UTCDateTimeString]).to.equal(@"1970-01-01 01:00:00");
}

- (void)testDateTimeStringWithoutTime {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:NO];
  expect([date pk_UTCDateTimeString]).to.equal(@"1970-01-01");
}

- (void)testDateString {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:YES];
  expect([date pk_UTCDateString]).to.equal(@"1970-01-01");
}

- (void)testDateStringWithoutTime {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:NO];
  expect([date pk_UTCDateString]).to.equal(@"1970-01-01");
}

- (void)testTimeString {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:YES];
  expect([date pk_UTCTimeString]).to.equal(@"01:00:00");
}

- (void)testTimeStringWithoutTime {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:NO];
  expect([date pk_UTCTimeString]).to.beNil();
}

@end
