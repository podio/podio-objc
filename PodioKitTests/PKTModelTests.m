//
//  PKTModelTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTTestModel.h"
#import "PKTNestedTestModel.h"

@interface PKTModelTests : XCTestCase

@end

@implementation PKTModelTests

- (void)testInitWithDictionary {
  PKTTestModel *obj = [self dummyTestModel];
  
  expect(obj.objectID).to.equal(12);
  expect(obj.firstValue).to.equal(@"some text 1");
  expect(obj.secondValue).to.equal(@"some text 2");
  
  expect(obj.nestedObjects).to.beKindOf([NSArray class]);
  expect(obj.nestedObjects).to.haveCountOf(2);
  expect(obj.nestedObjects[0]).to.beInstanceOf([PKTNestedTestModel class]);
  expect(obj.nestedObjects[1]).to.beInstanceOf([PKTNestedTestModel class]);
  
  expect(obj.nestedObject).to.beInstanceOf([PKTNestedTestModel class]);
  expect(obj.nestedObject.objectID).to.equal(125);
}

- (void)testCopying {
  PKTTestModel *obj = [self dummyTestModel];
  PKTTestModel *copyObj = [obj copy];
  expect(copyObj.objectID).to.equal(obj.objectID);
  expect(copyObj.firstValue).to.equal(obj.firstValue);
  expect(copyObj.secondValue).to.equal(obj.secondValue);
}

#pragma mark - Helpers

- (PKTTestModel *)dummyTestModel {
  NSDictionary *dictionary = @{
                               @"object_id": @12,
                               @"first_value": @"some text 1",
                               @"second_value": @"some text 2",
                               @"nested_objects":
                                 @[
                                   @{
                                     @"object_id": @123,
                                     @"first_value": @"some nested text 2",
                                     },
                                   @{
                                     @"object_id": @124,
                                     @"first_value": @"some nested text 2",
                                     }
                                   ],
                               @"nested_object":
                                 @{
                                   @"object_id": @125,
                                   @"first_value": @"some nested text 3",
                                   }
                               };
  
  return [[PKTTestModel alloc] initWithDictionary:dictionary];
}

@end
