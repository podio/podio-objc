//
//  PKTAppAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTAppsAPI.h"

@interface PKTAppAPITests : XCTestCase

@end

@implementation PKTAppAPITests

- (void)testRequestForGetApp {
  PKTRequest *request = [PKTAppsAPI requestForAppWithID:123];
  
  expect(request.path).to.equal(@"/app/123");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

- (void)testRequestToAddAppToWorkspace {
  PKTRequest *request = [PKTAppsAPI requestToAddAppToWorkspaceWithID:123 fields:@{@"text" : @"Some text"}];
  
  expect(request.path).to.equal(@"/app/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"space_id"]).to.equal(@123);
  expect(request.parameters[@"fields"]).to.equal(@{@"text" : @"Some text"});
}

- (void)testRequestForAppByURLLabel {
  PKTRequest *request = [PKTAppsAPI requestForAppInWorkspaceWithID:123 urlLabel:@"text"];
  
  expect(request.path).to.equal(@"/app/space/123/text");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

@end
