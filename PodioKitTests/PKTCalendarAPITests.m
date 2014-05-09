//
//  PKTCalendarAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTCalendarAPI.h"

@interface PKTCalendarAPITests : XCTestCase

@end

@implementation PKTCalendarAPITests

- (void)testRequestForCalendarEvents {
  NSDate *fromDate = [NSDate dateWithTimeIntervalSince1970:1399617610.8431301]; // May 9th, 2014
  NSDate *toDate = [NSDate dateWithTimeInterval:24 * 60 * 60 sinceDate:fromDate]; // May 10th, 2014
  PKTRequest *request = [PKTCalendarAPI requestForGlobalCalendarWithFromDate:fromDate toDate:toDate priority:10];
  
  expect(request.path).to.equal(@"/calendar/");
  expect(request.parameters[@"date_from"]).to.equal(@"2014-05-09");
  expect(request.parameters[@"date_to"]).to.equal(@"2014-05-10");
  expect(request.parameters[@"priority"]).to.equal(@10);
}

@end
