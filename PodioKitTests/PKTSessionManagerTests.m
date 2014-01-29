//
//  PKTSessionManagerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "PKTSessionManager.h"
#import "PKTClient.h"

@interface PKTSessionManagerTests : XCTestCase

@end

@implementation PKTSessionManagerTests

- (void)testSharedInstance {
  expect([PKTSessionManager sharedManager]).to.equal([PKTSessionManager sharedManager]);
}

- (void)testAuthenticationWithEmailAndPassword {
  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [request.URL.host isEqualToString:[PKTClient sharedClient].baseURL.host];
  } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
    return [OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil];
  }];

  PKTSessionManager *sessionManager = [PKTSessionManager new];

  __block PKTOAuth2Token *oauthToken = nil;
  [sessionManager authenticateWithEmail:@"some@email.com" password:@"password" completion:^(PKTOAuth2Token *token, NSError *error) {
    oauthToken = token;
  }];

  expect(oauthToken).willNot.beNil;
  expect(oauthToken).will.equal(sessionManager.oauthToken);
}

- (void)testAuthenticationWithAppIDAndToken {
  // TODO
}

- (void)testRefreshToken {
  // TODO
}

@end
