//
//  PKTDateValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTDateValueTransformer.h"

@interface PKTDateValueTransformerTests : XCTestCase

@end

@implementation PKTDateValueTransformerTests

- (void)testDateForwardTransformation {
  PKTDateValueTransformer *transformer = [PKTDateValueTransformer new];
  expect([transformer transformedValue:@"2014-05-02 18:32:22"]).to.beKindOf([NSDate class]);
}

- (void)testDateReverseTransformation {
  PKTDateValueTransformer *transformer = [PKTDateValueTransformer new];
  NSString *dateString = [transformer reverseTransformedValue:[NSDate dateWithTimeIntervalSince1970:0]];
  expect(dateString).to.equal(@"1970-01-01 00:00:00");
}

- (void)testDateReverseTransformationWithIgnoredTimeComponent {
  PKTDateValueTransformer *transformer = [PKTDateValueTransformer new];
  transformer.ignoresTimeComponent = YES;
  
  NSString *dateString = [transformer reverseTransformedValue:[NSDate dateWithTimeIntervalSince1970:0]];
  
  expect(dateString).to.equal(@"1970-01-01");
}

@end
