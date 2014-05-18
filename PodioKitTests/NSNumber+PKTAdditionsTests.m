//
//  NSNumber+PKTAdditionsTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumber+PKTAdditions.h"

@interface NSNumber_PKTAdditionsTests : XCTestCase

@end

@implementation NSNumber_PKTAdditionsTests

- (void)testStringToNumber {
  expect([NSNumber pkt_numberFromUSNumberString:@"123532.324400"]).to.equal(@123532.3244);
}

- (void)testNumberToString {
  expect([@123532.3244 pkt_USNumberString]).to.equal(@"123532.3244");
}

@end
