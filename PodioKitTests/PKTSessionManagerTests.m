//
//  PKTSessionManagerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTSessionManager.h"

@interface PKTSessionManagerTests : XCTestCase

@end

@implementation PKTSessionManagerTests

- (void)testSharedInstance {
  expect([PKTSessionManager sharedManager]).to.equal([PKTSessionManager sharedManager]);
}

@end
