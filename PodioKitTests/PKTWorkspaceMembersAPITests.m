//
//  PKTWorkspaceMembersAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 19/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTWorkspaceMembersAPI.h"

@interface PKTWorkspaceMembersAPITests : XCTestCase

@end

@implementation PKTWorkspaceMembersAPITests

- (void)testRequestToAddMembersToWorkspaceWithDefaultRole {
  PKTRequest *request = [PKTWorkspaceMembersAPI requestToAddMembersToSpaceWithID:1234
                                                                            role:PKTWorkspaceMemberRoleUnknown
                                                                         message:@"Join my workspace"
                                                                         userIDs:@[@111, @222]
                                                                      profileIDs:@[@333, @444]
                                                                          emails:@[@"john@domain.com", @"laura@domain.com"]];
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/space/1234/member/");
  expect(request.parameters[@"message"]).to.equal(@"Join my workspace");
  expect(request.parameters[@"role"]).to.beNil();
  expect(request.parameters[@"users"]).to.equal(@[@111, @222]);
  expect(request.parameters[@"profiles"]).to.equal(@[@333, @444]);
  expect(request.parameters[@"mails"]).to.equal(@[@"john@domain.com", @"laura@domain.com"]);
}

- (void)testRequestToAddMembersToWorkspaceWithAdminRole {
  PKTRequest *request = [PKTWorkspaceMembersAPI requestToAddMembersToSpaceWithID:1234
                                                                            role:PKTWorkspaceMemberRoleAdmin
                                                                         message:@"Join my workspace"
                                                                         userIDs:@[@111, @222]
                                                                      profileIDs:@[@333, @444]
                                                                          emails:@[@"john@domain.com", @"laura@domain.com"]];
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/space/1234/member/");
  expect(request.parameters[@"message"]).to.equal(@"Join my workspace");
  expect(request.parameters[@"role"]).to.equal(@"admin");
  expect(request.parameters[@"users"]).to.equal(@[@111, @222]);
  expect(request.parameters[@"profiles"]).to.equal(@[@333, @444]);
  expect(request.parameters[@"mails"]).to.equal(@[@"john@domain.com", @"laura@domain.com"]);
}

@end
