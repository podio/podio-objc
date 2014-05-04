//
//  PKTBlockValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTBlockValueTransformer.h"

@interface PKTBlockValueTransformerTests : XCTestCase

@end

@implementation PKTBlockValueTransformerTests

- (void)testTransformationWithBlock {
  PKTBlockValueTransformer *transformer = [PKTBlockValueTransformer transformerWithBlock:^id(NSNumber *num) {
    return @([num integerValue] * [num integerValue]);
  }];
  
  expect([transformer transformedValue:@3]).to.equal(@9);
}

@end
