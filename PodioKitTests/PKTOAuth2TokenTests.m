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

- (void)testInitWithAccessTokenRefreshTokenTransferTokenExpiresOnRefData {
  NSString *accessToken, *refreshToken, *transferToken;
  accessToken = @"aToken";
  refreshToken = @"anotherToken";
  transferToken = @"someOtherToken";

  NSDictionary *refData = @{@"test": @"value"};

  NSDate *expiresOn = [NSDate dateWithTimeIntervalSinceNow:1234];

  PKTOAuth2Token *token = [[PKTOAuth2Token alloc] initWithAccessToken:accessToken refreshToken:refreshToken expiresOn:expiresOn refData:refData];

  expect(token.accessToken).to.equal(accessToken);
  expect(token.refreshToken).to.equal(refreshToken);
  expect(token.refData).to.equal(refData);
  expect(token.expiresOn).to.equal(expiresOn);
}

- (void)testTokenFromDictionary {
  NSDictionary *dictionary = @{
    @"access_token": @"some_token",
    @"refresh_token": @"some_other_token",
    @"expires_in": @1234,
    @"ref": @{@"test": @"value"}
  };

  PKTOAuth2Token *token = [PKTOAuth2Token tokenFromDictionary:dictionary];

  expect(token.accessToken).to.equal(dictionary[@"access_token"]);
  expect(token.refreshToken).to.equal(dictionary[@"refresh_token"]);
  expect([token.expiresOn timeIntervalSince1970]).to.beCloseToWithin([[NSDate date] timeIntervalSince1970] + [dictionary[@"expires_in"] doubleValue], 1);
  expect(token.refData).to.equal(dictionary[@"ref"]);
}

@end
