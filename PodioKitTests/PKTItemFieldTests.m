//
//  PKTItemFieldTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTItemField.h"

@interface PKTItemFieldTests : XCTestCase

@end

@implementation PKTItemFieldTests

- (void)testInitWithAppField {
  PKTAppField *appField = [[PKTAppField alloc] initWithFieldID:123 externalID:@"title" type:PKTAppFieldTypeText];
  PKTItemField *itemField = [[PKTItemField alloc] initWithAppField:appField values:@[@"Some text"]];
  
  expect(itemField.fieldID).to.equal(123);
  expect(itemField.externalID).to.equal(@"title");
  expect(itemField.type).to.equal(PKTAppFieldTypeText);
}

- (void)testSetValues {
  PKTItemField *field = [[PKTItemField alloc] init];
  [field setValues:@[@"First value", @"Second value"]];
  
  expect(field.values).to.haveCountOf(2);
  expect(field.values[0]).to.equal(@"First value");
  expect(field.values[1]).to.equal(@"Second value");
}

- (void)testSetFirstValue {
  PKTItemField *field = [[PKTItemField alloc] init];
  field.value = @"Some text";
  
  expect(field.values).to.haveCountOf(1);
  expect(field.value).to.equal(@"Some text");
}

- (void)testAddValue {
  PKTItemField *field = [[PKTItemField alloc] init];
  [field addValue:@"First value"];
  [field addValue:@"Second value"];
  
  expect(field.values).to.haveCountOf(2);
  expect(field.values[0]).to.equal(@"First value");
  expect(field.values[1]).to.equal(@"Second value");
}

- (void)testRemoveValue {
  PKTItemField *field = [[PKTItemField alloc] init];
  [field addValue:@"First value"];
  [field addValue:@"Second value"];
  
  [field removeValue:@"First value"];
  
  expect(field.values).to.haveCountOf(1);
  expect(field.values[0]).to.equal(@"Second value");
}

- (void)testRemoveValueAtIndex {
  PKTItemField *field = [[PKTItemField alloc] init];
  [field addValue:@"First value"];
  [field addValue:@"Second value"];
  
  [field removeValueAtIndex:0];
  
  expect(field.values).to.haveCountOf(1);
  expect(field.values[0]).to.equal(@"Second value");
}

@end
