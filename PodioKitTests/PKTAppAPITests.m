//
//  PKTAppAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTAppAPI.h"

@interface PKTAppAPITests : XCTestCase

@end

@implementation PKTAppAPITests

- (void)testRequestForGetApp {
  PKTRequest *request = [PKTAppAPI requestForAppWithID:123];
  
  expect(request.path).to.equal(@"/app/123");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

@end
