//
//  PKTModelValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTModelValueTransformer.h"
#import "PKTTestModel.h"

@interface PKTModelValueTransformerTests : XCTestCase

@end

@implementation PKTModelValueTransformerTests

- (void)testForwardTransformationOfSingleObject {
  PKTModelValueTransformer *transformer = [PKTModelValueTransformer transformerWithModelClass:[PKTTestModel class]];
  
  PKTTestModel *obj = [transformer transformedValue:@{}];
  
  expect(obj).to.beInstanceOf([PKTTestModel class]);
}

- (void)testForwardTransformationOfArrayOfObjects {
  PKTModelValueTransformer *transformer = [PKTModelValueTransformer transformerWithModelClass:[PKTTestModel class]];

  NSArray *objs = [transformer transformedValue:@[@{}, @{}, @{}]];
  
  expect(objs).to.beKindOf([NSArray class]);
  expect(objs).to.haveCountOf(3);
  expect(objs[0]).to.beInstanceOf([PKTTestModel class]);
  expect(objs[1]).to.beInstanceOf([PKTTestModel class]);
  expect(objs[2]).to.beInstanceOf([PKTTestModel class]);
}

@end
