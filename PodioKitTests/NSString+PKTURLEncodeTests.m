//
//  NSString+PKTURLEncodeTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+PKTURLEncode.h"

@interface NSString_PKTURLEncodeTests : XCTestCase

@end

@implementation NSString_PKTURLEncodeTests

- (void)testURLEncode {
  expect([@"some@%?=#string" pkt_encodeString]).to.equal(@"some%40%25%3F%3D%23string");
}

- (void)testURLEncodeDecode {
  NSString *stringToEncode = @"some@%?=#string";
  expect([[stringToEncode pkt_encodeString] pkt_decodeString]).to.equal(stringToEncode);
}

@end
