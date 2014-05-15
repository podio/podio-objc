//
//  PKTDurationTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTDuration.h"

@interface PKTDurationTests : XCTestCase

@end

@implementation PKTDurationTests

- (void)testInitFromTotalSeconds {
  PKTDuration *duration = [[PKTDuration alloc] initWithTotalSeconds:101010];
  expect(duration.hours).to.equal(28);
  expect(duration.minutes).to.equal(3);
  expect(duration.seconds).to.equal(30);
  expect(duration.totalSeconds).to.equal(101010);
}

- (void)testInitFromHoursAndMinutesAndSeconds {
  PKTDuration *duration = [[PKTDuration alloc] initWithHours:28 minutes:3 seconds:30];
  expect(duration.hours).to.equal(28);
  expect(duration.minutes).to.equal(3);
  expect(duration.seconds).to.equal(30);
  expect(duration.totalSeconds).to.equal(101010);
}

@end
