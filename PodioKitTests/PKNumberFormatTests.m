//
//  PKNumberFormatTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/22/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "NSNumber+PKFormat.h"

@interface PKNumberFormatTests : SenTestCase

@end

@implementation PKNumberFormatTests

- (void)testNumberToString {
  NSString *string = [@43.4565 pk_numberStringWithUSLocale];
  STAssertTrue([string isEqualToString:@"43.4565"], @"String did not match expected 43.4565, got %@", string);
  
  NSString *string2 = [@32 pk_numberStringWithUSLocale];
  STAssertTrue([string2 isEqualToString:@"32"], @"String did not match expected 32, got %@", string2);
}

- (void)testStringToNumber {
  NSNumber *number = [NSNumber pk_numberFromStringWithUSLocale:@"43.4565"];
  STAssertTrue([number isEqualToNumber:@43.4565], @"Number did not match expected 43.4565, got %@", number);

  NSNumber *number2 = [NSNumber pk_numberFromStringWithUSLocale:@"32"];
  STAssertTrue([number2 isEqualToNumber:@32], @"Number did not match expected 32, got %@", number2);
}

@end
