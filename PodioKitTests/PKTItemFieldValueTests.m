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
#import "PKTContactItemFieldValue.h"
#import "PKTCalculationItemFieldValue.h"
#import "PKTCategoryItemFieldValue.h"

@interface PKTItemFieldValueTests : XCTestCase

@end

@implementation PKTItemFieldValueTests

- (void)testTitleValue {
  NSDictionary *valueDict = @{@"value" : @"This is a title"};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeTitle valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTBasicItemFieldValue class]);
  expect(value.valueDictionary).to.equal(valueDict);
}

- (void)testTextValue {
  NSDictionary *valueDict = @{@"value" : @"This is a text"};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeText valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTBasicItemFieldValue class]);
  expect(value.valueDictionary).to.equal(valueDict);
}

- (void)testDateValue {
  NSDictionary *valueDict = @{@"start" : @"2014-04-30 15:30:00",
                              @"end" : @"2014-04-30 16:00:00"};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeDate valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTDateItemFieldValue class]);
  expect(value.valueDictionary).to.equal(valueDict);
}

- (void)testMoneyValue {
  NSDictionary *valueDict = @{@"value" : @125.532,
                              @"currency" : @"DKK"};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeMoney valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTMoneyItemFieldValue class]);
  expect(value.valueDictionary).to.equal(valueDict);
}

- (void)testEmbedValue {
  NSDictionary *valueDict = @{@"embed" : @{@"embed_id" : @1111},
                              @"file" : @{@"file_id" : @2222}};
  
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeEmbed valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTEmbedItemFieldValue class]);
  expect(value.valueDictionary).to.equal(@{@"embed" : @1111, @"file" : @2222});
}

- (void)testImageValue {
  NSDictionary *valueDict = @{@"value" : @{@"file_id" : @2222}};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeImage valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTFileItemFieldValue class]);
  expect(value.valueDictionary).to.equal(@{@"value" : @2222});
}

- (void)testAppValue {
  NSDictionary *valueDict = @{@"value" : @{@"item_id" : @3333}};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeApp valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTAppItemFieldValue class]);
  expect(value.valueDictionary).to.equal(@{@"value" : @3333});
}

- (void)testContactValue {
  NSDictionary *valueDict = @{@"value" : @{@"profile_id" : @4444}};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeContact valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTContactItemFieldValue class]);
  expect(value.valueDictionary).to.equal(@{@"value" : @4444});
}

- (void)testCalculationValue {
  NSDictionary *valueDict = @{@"value" : @324};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeCalculation valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTCalculationItemFieldValue class]);
  expect(value.valueDictionary).to.beNil();
}

- (void)testCategoryValue {
  NSDictionary *valueDict = @{@"value" : @{@"id" : @123}};
  PKTItemFieldValue *value = [PKTItemFieldValue valueWithType:PKTAppFieldTypeCategory valueDictionary:valueDict];
  expect(value).to.beInstanceOf([PKTCategoryItemFieldValue class]);
  expect(value.valueDictionary).to.equal(@{@"value" : @123});
}

@end
