//
//  PKTRequestSerializerTests.m
//  PodioKit
//
//  Created by Romain Briche on 29/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTRequestSerializer.h"
#import "PKTRequestSerializer+Test.h"

@interface PKTRequestSerializerTests : XCTestCase

@end

@implementation PKTRequestSerializerTests

- (void)testSetAuthorizationHeaderFieldWithOAuth2AccessToken {
  NSString *accessToken = @"aToken";

  PKTRequestSerializer *requestSerializer = [PKTRequestSerializer serializer];
  [requestSerializer setAuthorizationHeaderFieldWithOAuth2AccessToken:accessToken];

  NSString *expectedHTTPHeader = [NSString stringWithFormat:@"OAuth2 %@", accessToken];
  expect([requestSerializer mutableHTTPRequestHeaders][@"Authorization"]).to.equal(expectedHTTPHeader);
}

@end
