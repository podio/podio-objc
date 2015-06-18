//
//  PKTDatastoreTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 20/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTDatastore.h"
#import "PKTAsyncTask.h"

@interface PKTDatastoreTests : XCTestCase

@end

@implementation PKTDatastoreTests

- (void)testSharedStoreReturnsSameInstance {
  expect([PKTDatastore sharedStore]).to.equal([PKTDatastore sharedStore]);
}

- (void)testStoreAndRetrieveObject {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  [store storeObject:value forKey:@"my-object"];
  
  expect([store storedObjectForKey:@"my-object"]).to.equal(value);
}

- (void)testStoreObjectAcrossStoreInstances {
  PKTDatastore *store1 = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  [store1 storeObject:value forKey:@"my-object"];
  
  PKTDatastore *store2 = [PKTDatastore storeWithName:@"TestStore"];
  expect([store2 storedObjectForKey:@"my-object"]).to.equal(value);
}

- (void)testCachesStoredObject {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  [store storeObject:value forKey:@"my-object"];
  
  NSDictionary *retrieved = (NSDictionary *)[store storedObjectForKey:@"my-object"];
  expect(value == retrieved).to.beTruthy();
}

- (void)testFetchStoredObjectAsynchronously {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  [store storeObject:value forKey:@"my-object"];
  
  __block NSDictionary *retrieved = nil;
  [[store fetchStoredObjectForKey:@"my-object"] onComplete:^(id result, NSError *error) {
    retrieved = result;
  }];
  
  expect(retrieved).will.equal(value);
}

- (void)testSubscripting {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  store[@"my-object"] = value;

  expect(store[@"my-object"]).to.equal(value);
}

- (void)testObjectExists {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  store[@"my-object"] = value;
  
  expect([store storedObjectExistsForKey:@"my-object"]).to.beTruthy();
  expect([store storedObjectExistsForKey:@"other-object"]).to.beFalsy();
}

- (void)testRemoveAllStoredObjects {
  PKTDatastore *store = [PKTDatastore storeWithName:@"TestStore"];
  
  NSDictionary *value = @{@"key" : @"value"};
  [store storeObject:value forKey:@"my-object"];
  
  expect([store storedObjectForKey:@"my-object"]).to.equal(value);
  
  [store removeAllStoredObjects];
  
  expect([store storedObjectForKey:@"my-object"]).to.beNil;
}

@end
