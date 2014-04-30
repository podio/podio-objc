//
//  PKTItemFieldValueTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTBasicItemFieldValue.h"
#import "PKTDateItemFieldValue.h"
#import "PKTMoneyItemFieldValue.h"
#import "PKTEmbedItemFieldValue.h"
#import "PKTFileItemFieldValue.h"
#import "PKTAppItemFieldValue.h"
#import "PKTProfileItemFieldValue.h"
#import "PKTCalculationItemFieldValue.h"
#import "PKTCategoryItemFieldValue.h"

@interface PKTItemFieldValueTests : XCTestCase

@end

@implementation PKTItemFieldValueTests

- (void)testBasicValue {
  NSDictionary *valueDict = @{@"value" : @"This is a title"};
  PKTBasicItemFieldValue *value = [[PKTBasicItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testDateValue {
  NSDictionary *valueDict = @{@"start" : @"2014-04-30 15:30:00",
                              @"end" : @"2014-04-30 16:00:00"};
  PKTDateItemFieldValue *value = [[PKTDateItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testMoneyValue {
  NSDictionary *valueDict = @{@"value" : @125.532,
                              @"currency" : @"DKK"};
  PKTMoneyItemFieldValue *value = [[PKTMoneyItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(valueDict);
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testEmbedValue {
  NSDictionary *valueDict = @{@"embed" : @{@"embed_id" : @1111},
                              @"file" : @{@"file_id" : @2222}};
  PKTEmbedItemFieldValue *value = [[PKTEmbedItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"embed" : @1111});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testFileValue {
  NSDictionary *valueDict = @{@"value" : @{@"file_id" : @2222}};
  PKTFileItemFieldValue *value = [[PKTFileItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @2222});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testAppValue {
  NSDictionary *valueDict = @{@"value" : @{@"item_id" : @3333}};
  PKTAppItemFieldValue *value = [[PKTAppItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @3333});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testContactValue {
  NSDictionary *valueDict = @{@"value" : @{@"profile_id" : @4444}};
  PKTProfileItemFieldValue *value = [[PKTProfileItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @4444});
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testCalculationValue {
  NSDictionary *valueDict = @{@"value" : @324};
  PKTCalculationItemFieldValue *value = [[PKTCalculationItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.beNil();
  expect(value.unboxedValue).toNot.beNil();
}

- (void)testCategoryValue {
  NSDictionary *valueDict = @{@"value" : @{@"id" : @123}};
  PKTCategoryItemFieldValue *value = [[PKTCategoryItemFieldValue alloc] initFromValueDictionary:valueDict];
  expect(value.valueDictionary).to.equal(@{@"value" : @123});
  expect(value.unboxedValue).toNot.beNil();
}

@end
