//
//  NSString+PKTURLTests.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSString+PKTURL.h"

@interface NSString_PKTURLTests : XCTestCase

@end

@implementation NSString_PKTURLTests

- (void)testEscapedURLString {
  NSString *unescapedString = @"Hello,!*'();:@&=+$,/?%#[]{}";
  NSString *escapedString = @"Hello%2C%21%2A%27%28%29%3B%3A%40%26%3D%2B%24%2C%2F%3F%25%23%5B%5D%7B%7D";

  expect([unescapedString pkt_escapedURLString]).to.equal(escapedString);
}

- (void)testUnescapedURLString {
  NSString *unescapedString = @"Hello,!*'();:@&=+$,/?%#[]{}";
  NSString *escapedString = @"Hello%2C%21%2A%27%28%29%3B%3A%40%26%3D%2B%24%2C%2F%3F%25%23%5B%5D%7B%7D";

  expect([escapedString pkt_unescapedURLString]).to.equal(unescapedString);
}

@end
