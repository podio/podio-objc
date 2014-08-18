//
//  PKTWorkspacesAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTWorskpacesAPI.h"

@interface PKTWorkspacesAPITests : XCTestCase

@end

@implementation PKTWorkspacesAPITests

- (void)testCreateDefaultWorkspace {
  PKTRequest *request = [PKTWorskpacesAPI requestToCreateWorkspaceWithName:@"My Workspace" organizationID:1234 privacy:PKTWorskpacePrivacyDefault];
  
  expect(request.path).to.equal(@"/space/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"name"]).to.equal(@"My Workspace");
  expect(request.parameters[@"org_id"]).to.equal(@1234);
  expect(request.parameters[@"privacy"]).to.beNil();
}

- (void)testCreateOpenWorkspace {
  PKTRequest *request = [PKTWorskpacesAPI requestToCreateWorkspaceWithName:@"My Workspace" organizationID:1234 privacy:PKTWorskpacePrivacyOpen];
  
  expect(request.path).to.equal(@"/space/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"name"]).to.equal(@"My Workspace");
  expect(request.parameters[@"org_id"]).to.equal(@1234);
  expect(request.parameters[@"privacy"]).to.equal(@"open");
}

- (void)testCreateClosedWorkspace {
  PKTRequest *request = [PKTWorskpacesAPI requestToCreateWorkspaceWithName:@"My Workspace" organizationID:1234 privacy:PKTWorskpacePrivacyClosed];
  
  expect(request.path).to.equal(@"/space/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"name"]).to.equal(@"My Workspace");
  expect(request.parameters[@"org_id"]).to.equal(@1234);
  expect(request.parameters[@"privacy"]).to.equal(@"closed");
}

@end
