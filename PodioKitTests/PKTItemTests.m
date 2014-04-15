//
//  PKTItemTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTItem.h"

@interface PKTItemTests : XCTestCase

@end

@implementation PKTItemTests

- (void)testSubscriptingForItemFields {
  PKTItem *item = [PKTItem itemForAppWithID:123];
  item[@"text"] = @"Some text";
  item[@"number"] = @12;
  
  expect(item[@"text"]).to.equal(@"Some text");
  expect(item[@"number"]).to.equal(@12);
  
  NSDictionary *expectedFields = @{@"text": @"Some text", @"number": @12};
  expect(item.fields).to.equal(expectedFields);
}

- (void)testItemFromDictionary {
  NSDictionary *dict = @{@"item_id": @1234,
                         @"title"  : @"Some item title"};
  
  PKTItem *item = [[PKTItem alloc] initWithDictionary:dict];
  expect(item.itemID).to.equal(1234);
  expect(item.title).to.equal(@"Some item title");
}

@end
