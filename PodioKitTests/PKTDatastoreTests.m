//
//  PKTDatastoreTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 20/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTDatastore.h"

@interface PKTDatastoreTests : XCTestCase

@end

@implementation PKTDatastoreTests

- (void)testSharedStoreReturnsSameInstance {
  expect([PKTDatastore sharedStore]).to.equal([PKTDatastore sharedStore]);
}

- (void)testDefaultPathWithName {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
  NSString *expectedPath = [NSString stringWithFormat:@"%@/PodioKit/v%@/Data/TestStore", documentsPath, @([PKTDatastore version])];
  expect(store.path).to.equal(expectedPath);
}

@end
