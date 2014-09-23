//
//  NSDate+PKFormattingTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSDate+PKFormatting.h"

@interface NSDate_PKFormattingTests : SenTestCase

@end

@implementation NSDate_PKFormattingTests

- (void)testDateFromDateTimeString {
  NSDate *date = [NSDate pk_dateFromUTCDateTimeString:@"1970-01-01 00:00:00"];
  expect(date).toNot.beNil();
}

- (void)testDateFromDateString {
  NSDate *date = [NSDate pk_dateFromUTCDateString:@"1970-01-01"];
  expect(date).toNot.beNil();
}

- (void)testDateTimeString {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:YES];
  expect([date pk_UTCDateTimeString]).to.equal(@"1970-01-01 00:00:00");
}

- (void)testDateString {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:YES];
  expect([date pk_UTCDateString]).to.equal(@"1970-01-01");
}

- (void)testTimeString {
  PKDate *date = [PKDate dateWithDate:[NSDate dateWithTimeIntervalSince1970:0] includesTimeComponent:YES];
  expect([date pk_UTCTimeString]).to.equal(@"00:00:00");
}

@end
