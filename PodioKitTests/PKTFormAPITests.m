//
//  PKTFormAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTFormAPI.h"

@interface PKTFormAPITests : XCTestCase

@end

@implementation PKTFormAPITests

- (void)testRequestForForm {
  PKTRequest *request = [PKTFormAPI requestForFormWithID:12345];
  
  expect(request.path).to.equal(@"/form/12345");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

@end
