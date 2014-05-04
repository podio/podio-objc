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
  NSDictionary *body = @{@"key" : @"value"};
  PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:200 body:body];
  expect(response.statusCode).to.equal(200);
  expect(response.body).to.equal(body);
}

@end
