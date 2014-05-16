//
//  PKTAppFieldTypeValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTAppFieldTypeValueTransformer.h"
#import "PKTAppField.h"

@interface PKTAppFieldTypeValueTransformerTests : XCTestCase

@end

@implementation PKTAppFieldTypeValueTransformerTests

- (void)testAppFieldTypValueTransformation {
  PKTAppFieldTypeValueTransformer *transformer = [PKTAppFieldTypeValueTransformer new];
  expect([transformer transformedValue:@"text"]).to.equal(PKTAppFieldTypeText);
  expect([transformer transformedValue:@"number"]).to.equal(PKTAppFieldTypeNumber);
  expect([transformer transformedValue:@"image"]).to.equal(PKTAppFieldTypeImage);
  expect([transformer transformedValue:@"date"]).to.equal(PKTAppFieldTypeDate);
  expect([transformer transformedValue:@"app"]).to.equal(PKTAppFieldTypeApp);
  expect([transformer transformedValue:@"contact"]).to.equal(PKTAppFieldTypeContact);
  expect([transformer transformedValue:@"money"]).to.equal(PKTAppFieldTypeMoney);
  expect([transformer transformedValue:@"progress"]).to.equal(PKTAppFieldTypeProgress);
  expect([transformer transformedValue:@"location"]).to.equal(PKTAppFieldTypeLocation);
  expect([transformer transformedValue:@"duration"]).to.equal(PKTAppFieldTypeDuration);
  expect([transformer transformedValue:@"embed"]).to.equal(PKTAppFieldTypeEmbed);
  expect([transformer transformedValue:@"calculation"]).to.equal(PKTAppFieldTypeCalculation);
  expect([transformer transformedValue:@"category"]).to.equal(PKTAppFieldTypeCategory);
}

@end
