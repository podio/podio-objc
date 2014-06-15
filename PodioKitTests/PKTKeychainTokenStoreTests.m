//
//  PKTKeychainTokenStoreTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OCMock/OCMock.h>
#import "PKTKeychainTokenStore.h"
#import "PKTKeychain.h"

@interface PKTKeychainTokenStoreTests : XCTestCase

@property (nonatomic, strong) id testKeychain;
@property (nonatomic, strong) PKTKeychainTokenStore *testStore;

@end

@implementation PKTKeychainTokenStoreTests

- (void)setUp {
  [super setUp];
  self.testKeychain = [OCMockObject mockForClass:[PKTKeychain class]];
  self.testStore = [[PKTKeychainTokenStore alloc] initWithKeychain:self.testKeychain];
}

- (void)tearDown {
  self.testStore = nil;
  [super tearDown];
}

- (void)testInitHasDefaultKeychain {
  PKTKeychainTokenStore *store = [[PKTKeychainTokenStore alloc] initWithService:@"MyService"];
  expect(store.keychain).toNot.beNil();
}

- (void)testStoreToken {
  PKTOAuth2Token *token = [self dummyToken];
  
  [[[self.testKeychain expect] andReturnValue:@YES] setObject:token ForKey:OCMOCK_ANY];
  [[[self.testKeychain expect] andReturn:token] objectForKey:OCMOCK_ANY];
  
  [self.testStore storeToken:token];
  expect([self.testStore storedToken]).to.equal(token);
  
  [self.testKeychain verify];
}

- (void)testDeleteToken {
  PKTOAuth2Token *token = [self dummyToken];
  
  [[[self.testKeychain expect] andReturnValue:@YES] setObject:token ForKey:OCMOCK_ANY];
  [[[self.testKeychain expect] andReturn:token] objectForKey:OCMOCK_ANY];
  
  [self.testStore storeToken:token];
  expect([self.testStore storedToken]).toNot.beNil();
  
  [(PKTKeychain *)[[self.testKeychain expect] andReturnValue:@YES] removeObjectForKey:OCMOCK_ANY];
  [[[self.testKeychain expect] andReturn:nil] objectForKey:OCMOCK_ANY];
  
  [self.testStore deleteStoredToken];
  expect([self.testStore storedToken]).to.beNil();
  
  [self.testKeychain verify];
}

#pragma mark - Helpers

- (PKTOAuth2Token *)dummyToken {
  return [[PKTOAuth2Token alloc] initWithDictionary:@{
    @"access_token" : @"abc123",
    @"refresh_token" : @"abc123",
    @"expires_in" : @3600,
    @"ref" : @{@"key": @"value"}
  }];
}

@end
