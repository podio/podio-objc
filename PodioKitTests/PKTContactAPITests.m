//
//  PKTContactAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTContactAPI.h"

@interface PKTContactAPITests : XCTestCase

@end

@implementation PKTContactAPITests

- (void)testRequetsForContactsWithUserID {
  PKTRequest *request = [PKTContactAPI requestForContactWithUserID:1234];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/contact/user/1234");
}

- (void)testRequetsForContactsWithProfileID {
  PKTRequest *request = [PKTContactAPI requestForContactWithProfileID:1234];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/contact/1234/v2");
}

- (void)testRequetsForContactsWithProfileIDs {
  PKTRequest *request = [PKTContactAPI requestForContactsWithProfileIDs:@[@1111, @2222, @3333]];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/contact/1111,2222,3333/v2");
}

- (void)testRequestForContacts {
  PKTRequest *request = [PKTContactAPI requestForContactsOfType:(PKTContactTypeSpace | PKTContactTypeUser)
                                                    excludeSelf:YES
                                                       ordering:PKTContactOrderingOverall
                                                         fields:@{@"name" : @"Seb"}
                                                 requiredFields:@[@"email", @"phone"]
                                                         offset:40
                                                          limit:20];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/contact/");
  expect(request.parameters[@"contact_type"]).to.equal(@"user,space");
  expect(request.parameters[@"exclude_self"]).to.equal(@YES);
  expect(request.parameters[@"order"]).to.equal(@"overall");
  expect(request.parameters[@"name"]).to.equal(@"Seb");
  expect(request.parameters[@"required"]).to.equal(@"email,phone");
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
}

- (void)testRequestForContactsInWorkspace {
  PKTRequest *request = [PKTContactAPI requestForContactsInWorkspaceWithID:1234
                                                               contactType:PKTContactTypeSpace
                                                               excludeSelf:YES
                                                                  ordering:PKTContactOrderingOverall
                                                                    fields:@{@"name" : @"Seb"}
                                                            requiredFields:@[@"email", @"phone"]
                                                                    offset:40
                                                                     limit:20];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/contact/space/1234/");
  expect(request.parameters[@"contact_type"]).to.equal(@"space");
  expect(request.parameters[@"exclude_self"]).to.equal(@YES);
  expect(request.parameters[@"order"]).to.equal(@"overall");
  expect(request.parameters[@"name"]).to.equal(@"Seb");
  expect(request.parameters[@"required"]).to.equal(@"email,phone");
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
}

@end
