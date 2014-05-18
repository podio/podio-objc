//
//  PKTItemTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTItem.h"

static NSString * const kExistingExternalID = @"title";
static NSString * const kUnsavedExternalID = @"new_title";

@interface PKTItemTests : XCTestCase

@end

@implementation PKTItemTests

- (void)testItemWithAppID {
  PKTItem *item = [PKTItem itemForAppWithID:1234];
  expect(item.appID).to.equal(1234);
}

- (void)testSetValueForExistingField {
  PKTItem *item = [self dummyItem];
  
  item[kExistingExternalID] = @"Some text";
  expect(item[kExistingExternalID]).to.equal(@"Some text");
}

- (void)testSetValuesForExistingField {
  PKTItem *item = [self dummyItem];
  
  NSArray *values = @[@"Some text 1", @"Some text 2"];
  [item setValues:values forField:kExistingExternalID];
  
  expect([item valuesForField:kExistingExternalID]).to.equal(values);
}

- (void)testAddValuesForExistingField {
  PKTItem *item = [self dummyItem];
  
  [item addValue:@"Some text 1" forField:kExistingExternalID];
  [item addValue:@"Some text 2" forField:kExistingExternalID];
  
  expect([item valuesForField:kExistingExternalID]).to.haveACountOf(2);
  expect([item valuesForField:kExistingExternalID]).to.equal(@[@"Some text 1", @"Some text 2"]);
}

- (void)testRemoveValueForExistingField {
  PKTItem *item = [self dummyItem];
  
  [item addValue:@"Some text 1" forField:kExistingExternalID];
  [item addValue:@"Some text 2" forField:kExistingExternalID];
  
  [item removeValue:@"Some text 1" forField:kExistingExternalID];
  
  expect([item valuesForField:kExistingExternalID]).to.haveACountOf(1);
  expect([item valuesForField:kExistingExternalID]).to.equal(@[@"Some text 2"]);
}

- (void)testRemoveValueAtIndexForExistingField {
  PKTItem *item = [self dummyItem];
  
  [item addValue:@"Some text 1" forField:kExistingExternalID];
  [item addValue:@"Some text 2" forField:kExistingExternalID];
  
  [item removeValueAtIndex:0 forField:kExistingExternalID];
  
  expect([item valuesForField:kExistingExternalID]).to.haveACountOf(1);
  expect([item valuesForField:kExistingExternalID]).to.equal(@[@"Some text 2"]);
}

- (void)testSetValueForUnsavedField {
  PKTItem *item = [self dummyItem];
  
  item[kUnsavedExternalID] = @"Some text";
  expect(item[kUnsavedExternalID]).to.equal(@"Some text");
}

- (void)testSetValuesForUnsavedField {
  PKTItem *item = [self dummyItem];
  
  NSArray *values = @[@"Some text 1", @"Some text 2"];
  [item setValues:values forField:kUnsavedExternalID];
  
  expect([item valuesForField:kUnsavedExternalID]).to.equal(values);
}

- (void)testAddValuesForUnsavedField {
  PKTItem *item = [self dummyItem];
  
  [item addValue:@"Some text 1" forField:kUnsavedExternalID];
  [item addValue:@"Some text 2" forField:kUnsavedExternalID];
  
  expect([item valuesForField:kUnsavedExternalID]).to.haveACountOf(2);
  expect([item valuesForField:kUnsavedExternalID]).to.equal(@[@"Some text 1", @"Some text 2"]);
}

- (void)testRemoveValueForUnsavedField {
  PKTItem *item = [self dummyItem];
  
  [item addValue:@"Some text 1" forField:kUnsavedExternalID];
  [item addValue:@"Some text 2" forField:kUnsavedExternalID];
  
  [item removeValue:@"Some text 1" forField:kUnsavedExternalID];
  
  expect([item valuesForField:kUnsavedExternalID]).to.haveACountOf(1);
  expect([item valuesForField:kUnsavedExternalID]).to.equal(@[@"Some text 2"]);
}

- (void)testRemoveValueAtIndexForUnsavedField {
  PKTItem *item = [self dummyItem];
  
  [item addValue:@"Some text 1" forField:kUnsavedExternalID];
  [item addValue:@"Some text 2" forField:kUnsavedExternalID];
  
  [item removeValueAtIndex:0 forField:kUnsavedExternalID];
  
  expect([item valuesForField:kUnsavedExternalID]).to.haveACountOf(1);
  expect([item valuesForField:kUnsavedExternalID]).to.equal(@[@"Some text 2"]);
}

#pragma mark - Helpers

- (PKTItem *)dummyItem {
  return [[PKTItem alloc] initWithDictionary:@{@"item_id" : @1111,
                                               @"app_id" : @2222,
                                               @"fields" :
                                                 @[
                                                   @{
                                                     @"field_id" : @1234,
                                                     @"external_id" : kExistingExternalID,
                                                     @"type" : @"text",
                                                     }
                                                   ]}];
}

@end
