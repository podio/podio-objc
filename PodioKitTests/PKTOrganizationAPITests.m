//
//  PKTOrganizationAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTOrganizationsAPI.h"

@interface PKTOrganizationAPITests : XCTestCase

@end

@implementation PKTOrganizationAPITests

- (void)testRequestForAllOrganizations {
  PKTRequest *request = [PKTOrganizationsAPI requestForAllOrganizations];
  expect(request.path).to.equal(@"/org/");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

- (void)testRequestForOrganizationWithID {
  PKTRequest *request = [PKTOrganizationsAPI requestForOrganizationWithID:123];
  expect(request.path).to.equal(@"/org/123");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

- (void)testRequestToUpdateOrganizationWithID {
  PKTRequest *request = [PKTOrganizationsAPI requestToUpdateOrganizationWithID:123 withName:@"Organisation name"];
  expect(request.path).to.equal(@"/org/123");
  expect(request.method).to.equal(PKTRequestMethodPUT);
  expect(request.parameters[@"name"]).to.equal(@"Organisation name");
}

@end
