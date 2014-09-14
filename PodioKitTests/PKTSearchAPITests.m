//
//  PKTSearchAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTSearchAPI.h"

@interface PKTSearchAPITests : XCTestCase

@end

@implementation PKTSearchAPITests

- (void)testGlobalSearchRequest {
  PKTSearchQuery *query = [PKTSearchQuery queryWithText:@"Some text"];
  query.referenceType = PKTReferenceTypeItem;
  query.returnCounts = NO;
  
  PKTRequest *request = [PKTSearchAPI requestToSearchGloballyWithQuery:query offset:40 limit:20];
  
  expect(request.path).to.equal(@"/search/v2");
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.parameters[@"query"]).to.equal(@"Some text");
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
  expect(request.parameters[@"ref_type"]).to.equal(@"item");
  expect(request.parameters[@"counts"]).to.equal(@NO);
}

@end
