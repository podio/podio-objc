//
//  PKTWorkspacesAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTWorkspacesAPI.h"

@interface PKTWorkspacesAPITests : XCTestCase

@end

@implementation PKTWorkspacesAPITests

- (void)requestToGetWorkspace {
  PKTRequest *request = [PKTWorkspacesAPI requestForWorkspaceWithID:1234];
  
  expect(request.path).to.equal(@"/space/1234");
  expect(request.method).to.equal(PKTRequestMethodGET);
}

- (void)testCreateDefaultWorkspace {
  PKTRequest *request = [PKTWorkspacesAPI requestToCreateWorkspaceWithName:@"My Workspace" organizationID:1234 privacy:PKTWorkspacePrivacyUnknown];
  
  expect(request.path).to.equal(@"/space/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"name"]).to.equal(@"My Workspace");
  expect(request.parameters[@"org_id"]).to.equal(@1234);
  expect(request.parameters[@"privacy"]).to.beNil();
}

- (void)testCreateOpenWorkspace {
  PKTRequest *request = [PKTWorkspacesAPI requestToCreateWorkspaceWithName:@"My Workspace" organizationID:1234 privacy:PKTWorkspacePrivacyOpen];
  
  expect(request.path).to.equal(@"/space/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"name"]).to.equal(@"My Workspace");
  expect(request.parameters[@"org_id"]).to.equal(@1234);
  expect(request.parameters[@"privacy"]).to.equal(@"open");
}

- (void)testCreateClosedWorkspace {
  PKTRequest *request = [PKTWorkspacesAPI requestToCreateWorkspaceWithName:@"My Workspace" organizationID:1234 privacy:PKTWorkspacePrivacyClosed];
  
  expect(request.path).to.equal(@"/space/");
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.parameters[@"name"]).to.equal(@"My Workspace");
  expect(request.parameters[@"org_id"]).to.equal(@1234);
  expect(request.parameters[@"privacy"]).to.equal(@"closed");
}

- (void)testToGetWorkspaceByURL {
  PKTRequest *request = [PKTWorkspacesAPI requestForWorkspaceWithURLString:@"https://podio.com/myorg/myspace"];
  
  expect(request.path).to.equal(@"/space/url");
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.parameters[@"url"]).to.equal(@"https://podio.com/myorg/myspace");
}

@end
