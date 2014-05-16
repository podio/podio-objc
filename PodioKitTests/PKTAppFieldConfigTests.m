//
//  PKTAppFieldConfigTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTAppFieldConfig.h"

@interface PKTAppFieldConfigTests : XCTestCase

@end

@implementation PKTAppFieldConfigTests

- (void)testInitWithDictionary {
  NSDictionary *dict = @{
      @"label" : @"What time?",
      @"description" : @"Some description",
      @"mapping" : @"meeting_time",
      @"settings" : @{@"key" : @"value"},
      @"delta" : @3,
      @"required" : @YES,
      @"visible" : @YES,
  };

  PKTAppFieldConfig *config = [[PKTAppFieldConfig alloc] initWithDictionary:dict];
  expect(config.label).to.equal(@"What time?");
  expect(config.descr).to.equal(@"Some description");
  expect(config.mapping).to.equal(PKTAppFieldMappingMeetingTime);
  expect(config.settings).to.equal(@{@"key" : @"value"});
  expect(config.delta).to.equal(3);
  expect(config.required).to.beTruthy();
  expect(config.visible).to.beTruthy();
}

@end
