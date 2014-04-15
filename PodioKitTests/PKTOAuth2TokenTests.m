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

@end
