//
//  NSString+PKTBase64Tests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+PKTBase64.h"

@interface NSString_PKTBase64Tests : XCTestCase

@end

@implementation NSString_PKTBase64Tests

- (void)testBase64Encoding {
  expect([@"SomeString:SomeOtherString" pkt_base64String]).to.equal(@"U29tZVN0cmluZzpTb21lT3RoZXJTdHJpbmc=");
}

@end
