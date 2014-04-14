//
//  PKTObjectTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTObject.h"

@interface PKTObjectTests : XCTestCase

@end

@implementation PKTObjectTests

- (void)tearDown {
  // Reset any client overrides from previous test cases
  [PKTObject setClient:nil];
}

- (void)testUsesSharedClientByDefault {
  expect([PKTObject client]).to.equal([PKTClient sharedClient]);
}

- (void)testUsesCustomClient {
  PKTClient *client = [[PKTClient alloc] initWithAPIKey:@"my-key" secret:@"my-secret"];
  [PKTObject setClient:client];
  
  expect([PKTObject client]).to.equal(client);
}

@end
