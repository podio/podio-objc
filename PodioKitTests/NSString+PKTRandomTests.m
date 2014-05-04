//
//  NSString+PKTRandomTests.m
//  PodioKit
//
//  Created by Romain Briche on 30/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+PKTRandom.h"

@interface NSString_PKTRandomTests : XCTestCase

@end

@implementation NSString_PKTRandomTests

- (void)testRandomHexString {
  NSUInteger length = 8;
  NSString *testString1, *testString2;
  testString1 = [NSString pkt_randomHexStringOfLength:length];
  testString2 = [NSString pkt_randomHexStringOfLength:length];
  expect([testString1 length]).to.equal(length);
  expect([testString2 length]).to.equal(length);
  expect(testString2).notTo.equal(testString1);

  length = 4;
  expect([[NSString pkt_randomHexStringOfLength:length] length]).to.equal(length);
}

@end
