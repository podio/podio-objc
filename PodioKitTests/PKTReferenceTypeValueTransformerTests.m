//
//  PKTReferenceTypeValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTConstants.h"
#import "PKTReferenceTypeValueTransformer.h"

@interface PKTReferenceTypeValueTransformerTests : XCTestCase

@end

@implementation PKTReferenceTypeValueTransformerTests

- (void)testTransformReferenceTypes {
  PKTReferenceTypeValueTransformer *transformer = [[PKTReferenceTypeValueTransformer alloc] init];
  expect([transformer transformedValue:@"app"]).to.equal(PKTReferenceTypeApp);
  expect([transformer transformedValue:@"item"]).to.equal(PKTReferenceTypeItem);
}

- (void)testReverseTransformReferenceTypes {
  PKTReferenceTypeValueTransformer *transformer = [[PKTReferenceTypeValueTransformer alloc] init];
  expect([transformer reverseTransformedValue:@(PKTReferenceTypeApp)]).to.equal(@"app");
  expect([transformer reverseTransformedValue:@(PKTReferenceTypeItem)]).to.equal(@"item");
}

@end
