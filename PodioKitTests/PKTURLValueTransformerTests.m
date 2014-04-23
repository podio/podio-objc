//
//  PKTURLValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTURLValueTransformer.h"

@interface PKTURLValueTransformerTests : XCTestCase

@end

@implementation PKTURLValueTransformerTests

- (void)testTransformURLStringToURL {
  PKTURLValueTransformer *transformer = [[PKTURLValueTransformer alloc] init];
  NSURL *url = [transformer transformedValue:@"https://www.google.com"];
  expect(url.absoluteString).to.equal(@"https://www.google.com");
}

@end
