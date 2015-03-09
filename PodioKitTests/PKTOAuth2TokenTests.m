//
//  PKTOAuth2TokenTests.m
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTOAuth2Token.h"

@interface PKTOAuth2TokenTests : XCTestCase

@end

@implementation PKTOAuth2TokenTests

- (void)testTokenFromDictionary {
  NSDictionary *dictionary = @{
    @"access_token": @"some_token",
    @"refresh_token": @"some_other_token",
    @"expires_in": @1234,
    @"ref": @{@"test": @"value"}
  };

  PKTOAuth2Token *token = [[PKTOAuth2Token alloc] initWithDictionary:dictionary];

  expect(token.accessToken).to.equal(dictionary[@"access_token"]);
  expect(token.refreshToken).to.equal(dictionary[@"refresh_token"]);
  expect([token.expiresOn timeIntervalSince1970]).to.beCloseToWithin([[NSDate date] timeIntervalSince1970] + [dictionary[@"expires_in"] doubleValue], 1);
  expect(token.refData).to.equal(dictionary[@"ref"]);
}

- (void)testTokenFromComponents {
  PKTOAuth2Token *token = [[PKTOAuth2Token alloc] initWithAccessToken:@"some_access_token"
                                                         refreshToken:@"some_refresh_token"
                                                        transferToken:@"some_transfer_token"
                                                            expiresOn:[NSDate dateWithTimeIntervalSinceNow:1234]
                                                              refData:@{@"test": @"value"}];
  
  expect(token.accessToken).to.equal(@"some_access_token");
  expect(token.refreshToken).to.equal(@"some_refresh_token");
  expect(token.transferToken).to.equal(@"some_transfer_token");
  expect([token.expiresOn timeIntervalSince1970]).to.beCloseToWithin([[NSDate date] timeIntervalSince1970] + 1234, 1);
  expect(token.refData).toNot.beNil();
}

- (void)testWillExpireInTrue {
  PKTOAuth2Token *token = [self tokenWithExpirationIntervalFromNow:100];
  expect([token willExpireWithinIntervalFromNow:1000]).to.beTruthy();
}

- (void)testWillExpireInFalse {
  PKTOAuth2Token *token = [self tokenWithExpirationIntervalFromNow:100];
  expect([token willExpireWithinIntervalFromNow:10]).to.beFalsy();
}

#pragma mark - Helpers

- (PKTOAuth2Token *)tokenWithExpirationIntervalFromNow:(NSTimeInterval)expiresIn {
  NSDictionary *dictionary = @{
      @"access_token": @"some_token",
      @"refresh_token": @"some_other_token",
      @"expires_in": @(expiresIn),
      @"ref": @{@"test": @"value"}
    };
  
  return [[PKTOAuth2Token alloc] initWithDictionary:dictionary];
}

@end
