//
//  PKTTaskAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTTaskAPI.h"
#import "PKTDateRange.h"

@interface PKTTaskAPITests : XCTestCase

@end

@implementation PKTTaskAPITests

- (void)testRequestForTasks {
  PKTRequest *request = [PKTTaskAPI requestForTasksWithParameters:[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
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

@end
