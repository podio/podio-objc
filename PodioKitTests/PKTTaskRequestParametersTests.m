//
//  PKTTaskRequestParametersTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTTaskRequestParameters.h"
#import "PKTReferenceIdentifier.h"
#import "PKTDateRange.h"

@interface PKTTaskRequestParametersTests : XCTestCase

@end

@implementation PKTTaskRequestParametersTests

- (void)testCompleted {
  expect([[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.completed = PKTTaskRequestParameterCompletedTrue;
  }] queryParameters]).to.equal(@{@"completed" : @YES});
}

- (void)testResponsible {
  expect([[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.responsibleUserID = 12345;
  }] queryParameters]).to.equal(@{@"responsible" : @12345});
}

- (void)testCompletedOn {
  expect([[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.completedOn = PKTTaskRequestParameterCompletedOn8Months;
  }] queryParameters]).to.equal(@{@"completed_on" : @"8_months"});
}

- (void)testSortBy {
  expect([[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.sortBy = PKTTaskRequestParameterSortByCreatedOn;
  }] queryParameters]).to.equal(@{@"sort_by" : @"created_on"});
}

- (void)testSortOrder {
  expect([[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.sortOrder = PKTTaskRequestParameterSortOrderDescending;
  }] queryParameters]).to.equal(@{@"sort_desc" : @YES});
}

- (void)testReferences {
  PKTTaskRequestParameters *params = [PKTTaskRequestParameters parameters];
  params.references = @[[PKTReferenceIdentifier identifierWithReferenceID:111 type:PKTReferenceTypeItem],
                        [PKTReferenceIdentifier identifierWithReferenceID:222 type:PKTReferenceTypeTask]];
  
  expect([params queryParameters]).to.equal(@{@"reference" : @"item:111,task:222"});
}

- (void)testDueDateRange {
  expect([[PKTTaskRequestParameters parametersWithBlock:^(PKTTaskRequestParameters *params) {
    params.dueDateRange = [PKTDateRange rangeWithStartDate:[NSDate dateWithTimeIntervalSince1970:1402840478]   // 2014-05-15
                                                   endDate:[NSDate dateWithTimeIntervalSince1970:1403013278]]; // 2014-05-17
  }] queryParameters]).to.equal(@{@"due_date" : @"2014-06-15-2014-06-17"});
}

@end
