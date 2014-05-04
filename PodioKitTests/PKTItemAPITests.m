//
//  PKTItemAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTItemAPI.h"

@interface PKTItemAPITests : XCTestCase

@end

@implementation PKTItemAPITests

- (void)testRequestToCreateItem {
  NSDictionary *fields = @{
                           @"text": @"Some text",
                           @"number_field": @123,
                           };
  NSArray *files = @[@233, @432];
  NSArray *tags = @[@"tag1", @"tag2"];
  
  PKTRequest *request = [PKTItemAPI requestToCreateItemInAppWithID:13242 fields:fields files:files tags:tags];
  
  expect(request.path).to.equal(@"/item/app/13242/");
  expect(request.parameters[@"fields"]).to.equal([fields copy]);
  expect(request.parameters[@"file_ids"]).to.equal(files);
  expect(request.parameters[@"tags"]).to.equal(tags);
}

- (void)testRequestToUpdateItem {
  NSDictionary *fields = @{
                           @"text": @"Some text",
                           @"number_field": @123,
                           };
  NSArray *files = @[@233, @432];
  NSArray *tags = @[@"tag1", @"tag2"];
  
  PKTRequest *request = [PKTItemAPI requestToUpdateItemWithID:333 fields:fields files:files tags:tags];
  
  expect(request.path).to.equal(@"/item/333");
  expect(request.parameters[@"fields"]).to.equal([fields copy]);
  expect(request.parameters[@"file_ids"]).to.equal(files);
  expect(request.parameters[@"tags"]).to.equal(tags);
}

- (void)testRequestToGetItem {
  PKTRequest *request = [PKTItemAPI requestForItemWithID:123];
  expect(request.path).to.equal(@"/item/123");
}

- (void)testRequestToGetFilteredItems {
  PKTRequest *request = [PKTItemAPI requestForFilteredItemsInAppWithID:123
                                                                offset:60
                                                                 limit:30
                                                                sortBy:@"created_on"
                                                            descending:YES
                                                              remember:YES];
  
  expect(request.path).to.equal(@"/item/app/123/filter/");
  expect(request.parameters[@"offset"]).to.equal(@60);
  expect(request.parameters[@"limit"]).to.equal(@30);
  expect(request.parameters[@"sort_by"]).to.equal(@"created_on");
  expect(request.parameters[@"sort_desc"]).to.equal(@YES);
  expect(request.parameters[@"remember"]).to.equal(@YES);
}

@end
