//
//  PKTTaskAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTTasksAPI.h"
#import "PKTDateRange.h"

@interface PKTTaskAPITests : XCTestCase

@end

@implementation PKTTaskAPITests

- (void)testRequestForTasks {
  PKTRequest *request = [PKTTasksAPI requestForTasksWithParameters:[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.responsibleUserID = 12345;
    params.sortOrder = PKTTaskRequestParameterSortOrderDescending;
    params.sortBy = PKTTaskRequestParameterSortByCreatedOn;
  }] offset:40 limit:20];
  
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/task/");
  expect(request.parameters[@"sort_by"]).toNot.beNil();
  expect(request.parameters[@"sort_desc"]).toNot.beNil();
  expect(request.parameters[@"responsible"]).toNot.beNil();
  expect(request.parameters[@"offset"]).to.equal(40);
  expect(request.parameters[@"limit"]).to.equal(20);
}

- (void)testRequestToCreateTask {
  PKTRequest *request = [PKTTasksAPI requestToCreateTaskWithText:@"Task title"
                                                    description:@"Task description"
                                                          dueOn:[NSDate dateWithTimeIntervalSince1970:1402840478] // 2014-06-15 13:54
                                                      isPrivate:YES
                                              responsibleUserID:12345
                                                    referenceID:1111
                                                  referenceType:PKTReferenceTypeItem
                                                          files:@[@111, @222]];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/task/");
  expect(request.parameters[@"text"]).to.equal(@"Task title");
  expect(request.parameters[@"description"]).to.equal(@"Task description");
  expect(request.parameters[@"due_on"]).to.equal(@"2014-06-15 13:54:38");
  expect(request.parameters[@"private"]).to.equal(@YES);
  expect(request.parameters[@"responsible"]).to.equal(@12345);
  expect(request.parameters[@"ref_id"]).to.equal(@1111);
  expect(request.parameters[@"ref_type"]).to.equal(@"item");
  expect(request.parameters[@"file_ids"]).to.equal(@[@111, @222]);
}

- (void)testRequestToUpdateTask {
  PKTRequest *request = [PKTTasksAPI requestToUpdateTaskWithID:33333
                                                         text:@"Task title"
                                                  description:@"Task description"
                                                        dueOn:[NSDate dateWithTimeIntervalSince1970:1402840478] // 2014-06-15 13:54
                                                    isPrivate:YES
                                            responsibleUserID:12345
                                                  referenceID:1111
                                                referenceType:PKTReferenceTypeItem
                                                        files:@[@111, @222]];
  
  expect(request.method).to.equal(PKTRequestMethodPUT);
  expect(request.path).to.equal(@"/task/33333");
  expect(request.parameters[@"text"]).to.equal(@"Task title");
  expect(request.parameters[@"description"]).to.equal(@"Task description");
  expect(request.parameters[@"due_on"]).to.equal(@"2014-06-15 13:54:38");
  expect(request.parameters[@"private"]).to.equal(@YES);
  expect(request.parameters[@"responsible"]).to.equal(@12345);
  expect(request.parameters[@"ref_id"]).to.equal(@1111);
  expect(request.parameters[@"ref_type"]).to.equal(@"item");
  expect(request.parameters[@"file_ids"]).to.equal(@[@111, @222]);
}

- (void)testRequestToAssignTask {
  PKTRequest *request = [PKTTasksAPI requestToAssignTaskWithID:1234 userID:1111];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/task/1234/assign");
  expect(request.parameters[@"responsible"]).to.equal(@1111);
}

- (void)testRequestToAssignTaskToNoOne {
  PKTRequest *request = [PKTTasksAPI requestToAssignTaskWithID:1234 userID:0];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/task/1234/assign");
  expect(request.parameters[@"responsible"]).to.equal([NSNull null]);
}

- (void)testRequestToCompleteTask {
  PKTRequest *request = [PKTTasksAPI requestToCompleteTaskWithID:1234];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/task/1234/complete");
}

- (void)testRequestToIncompleteTask {
  PKTRequest *request = [PKTTasksAPI requestToIncompleteTaskWithID:1234];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/task/1234/incomplete");
}

@end
