//
//  PKTRightValueTransformerTests.m
//  PodioKit
//
//  Created by Romain Briche on 20/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTRightValueTransformer.h"
#import "PKTRight.h"

@interface PKTRightValueTransformerTests : XCTestCase

@end

@implementation PKTRightValueTransformerTests

- (void)testTransformRightStrings {
  NSArray *rights = @[@"view", @"comment"];
  
  PKTRightValueTransformer *transformer = [PKTRightValueTransformer new];
  NSValue *rightValue = [transformer transformedValue:rights];
  PKTRight right;
  [rightValue getValue:&right];

  expect(right & PKTRightView).to.beGreaterThan(0);
  expect(right & PKTRightComment).to.beGreaterThan(0);
  expect(right & PKTRightUpdate).to.equal(0);
  expect(right & PKTRightRate).to.equal(0);
}

@end
