//
//  PKTDictionaryMappingValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTDictionaryMappingValueTransformer.h"

@interface PKTDictionaryMappingValueTransformerTests : XCTestCase

@end

@implementation PKTDictionaryMappingValueTransformerTests

- (void)testDictionaryTransformation {
  NSDictionary *mapping = @{
    @"A" : @1,
    @"B" : @2,
  };
  
  PKTDictionaryMappingValueTransformer *transformer = [[PKTDictionaryMappingValueTransformer alloc] initWithDictionary:mapping];
  
  expect([transformer transformedValue:@"A"]).to.equal(@1);
  expect([transformer transformedValue:@"B"]).to.equal(@2);
}

- (void)testReverseDictionaryTransformation {
  NSDictionary *mapping = @{
    @"A" : @1,
    @"B" : @2,
  };
  
  PKTDictionaryMappingValueTransformer *transformer = [[PKTDictionaryMappingValueTransformer alloc] initWithDictionary:mapping];
  
  expect([transformer reverseTransformedValue:@1]).to.equal(@"A");
  expect([transformer reverseTransformedValue:@2]).to.equal(@"B");
}

@end
