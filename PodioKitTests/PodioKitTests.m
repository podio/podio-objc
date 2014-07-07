//
//  PodioKitTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PodioKit.h"
#import "PKTClient.h"

@interface PodioKitTests : XCTestCase

@end

@implementation PodioKitTests

- (void)testSetupWithAPIKeyAndSecret {
  [PodioKit setupWithAPIKey:@"my-api-key" secret:@"my-api-secret"];
  expect([PKTClient defaultClient].apiKey).to.equal(@"my-api-key");
  expect([PKTClient defaultClient].apiSecret).to.equal(@"my-api-secret");
}

@end
