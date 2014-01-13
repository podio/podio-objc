//
//  PKNumberFormatTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/22/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NSNumber+PKFormat.h"

@interface PKNumberFormatTests : XCTestCase

@end

@implementation PKNumberFormatTests

- (void)testNumberToString {
  NSString *string = [@43.4565 pk_numberStringWithUSLocale];
  expect(string).to.equal(@"43.4565");
  
  string = [@32 pk_numberStringWithUSLocale];
  expect(string).to.equal(@"32");
}

- (void)testStringToNumber {
  NSNumber *number = [NSNumber pk_numberFromStringWithUSLocale:@"43.4565"];
  expect(number).to.equal(@43.4565);

  number = [NSNumber pk_numberFromStringWithUSLocale:@"32"];
  expect(number).to.equal(@32);
}

@end
