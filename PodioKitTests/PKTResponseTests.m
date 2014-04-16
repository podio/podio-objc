//
//  PKTResponseTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTResponse.h"

@interface PKTResponseTests : XCTestCase

@end

@implementation PKTResponseTests

- (void)testInit {
  NSDictionary *result = @{@"key" : @"value"};
  PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:200 resultObject:result];
  expect(response.statusCode).to.equal(200);
  expect(response.resultObject).to.equal(result);
}

@end
