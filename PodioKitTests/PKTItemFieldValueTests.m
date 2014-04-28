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
  // TODO
}

@end
