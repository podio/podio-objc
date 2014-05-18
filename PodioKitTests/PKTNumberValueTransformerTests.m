//
//  PKTNumberValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTNumberValueTransformer.h"

@interface PKTNumberValueTransformerTests : XCTestCase

@end

@implementation PKTNumberValueTransformerTests

- (void)testTransformStringToNumber {
  PKTNumberValueTransformer *transformer = [PKTNumberValueTransformer new];
  expect([transformer transformedValue:@"32.324"]).to.equal(@32.324);
}

- (void)testTransformNumberToString {
  PKTNumberValueTransformer *transformer = [PKTNumberValueTransformer new];
  expect([transformer reverseTransformedValue:@32.324]).to.equal(@"32.324");
}

@end
