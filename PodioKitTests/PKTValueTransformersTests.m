//
//  PKTValueTransformersTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTTestModel.h"

@interface PKTValueTransformersTests : XCTestCase

@end

@implementation PKTValueTransformersTests

- (void)testBlockTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_transformerWithBlock:^id(id value) {
    return nil;
  }];
  
  expect(transformer).to.beInstanceOf([PKTBlockValueTransformer class]);
}

- (void)testReversibleBlockTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_transformerWithBlock:^id(id value) {
    return nil;
  } reverseBlock:^id(id value) {
    return nil;
  }];
  
  expect(transformer).to.beInstanceOf([PKTReversibleBlockValueTransformer class]);
}

- (void)testModelTransformer {
  NSValueTransformer *transformer = [NSValueTransformer pkt_transformerWithModelClass:[PKTTestModel class]];
  
  expect(transformer).to.beInstanceOf([PKTModelValueTransformer class]);
}

@end
