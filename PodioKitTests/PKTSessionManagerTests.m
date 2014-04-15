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
#import "PKTOAuth2Token.h"
#import "PKSessionManager+Test.h"

@interface PKTSessionManagerTests : XCTestCase

@property (nonatomic, strong) PKTSessionManager *testSessionManager;

@end

@implementation PKTSessionManagerTests

- (void)setUp {
  [super setUp];
  PKTClient *client = [[PKTClient alloc] initWithAPIKey:@"apiKey" secret:@"apiSecret"];
  self.testSessionManager = [[PKTSessionManager alloc] initWithClient:client];

  
  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [request.URL.host isEqualToString:self.testSessionManager.client.baseURL.host];
  } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
    return [OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil];
  }];
}

- (void)tearDown {
  self.testSessionManager = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testSharedInstance {
  expect([PKTSessionManager sharedManager]).to.equal([PKTSessionManager sharedManager]);
  expect([PKTSessionManager sharedManager].client).to.equal([PKTClient sharedClient]);
}

- (void)testInitWithClient {
  PKTClient *client = [[PKTClient alloc] initWithAPIKey:@"apiKey" secret:@"apiSecret"];

  PKTSessionManager *manager = [[PKTSessionManager alloc] initWithClient:client];
  expect(manager.client).to.equal(client);
  expect(manager.oauthToken).to.beNil();
  expect(manager.isAuthenticated).to.beFalsy();
}

//- (void)testAuthenticationWithEmailAndPassword {
//  expect(self.testSessionManager.isAuthenticated).to.beFalsy();
//
//  [self.testSessionManager authenticateWithEmail:@"some@email.com" password:@"password" completion:nil];
//
//  expect(self.testSessionManager.isAuthenticated).will.beTruthy();
//  expect(self.testSessionManager.oauthToken).willNot.beNil;
//}
//
//- (void)testAuthenticationWithAppIDAndToken {
//  expect(self.testSessionManager.isAuthenticated).to.beFalsy();
//
//  [self.testSessionManager authenticateWithAppID:@"someAppID" token:@"someAppToken" completion:nil];
//
//  expect(self.testSessionManager.isAuthenticated).will.beTruthy();
//  expect(self.testSessionManager.oauthToken).willNot.beNil;
//}
//
//- (void)testRefreshToken {
//  expect(self.testSessionManager.isAuthenticated).to.beFalsy();
//
//  [self.testSessionManager authenticateWithEmail:@"some@email.com" password:@"password" completion:nil];
//
//  expect(self.testSessionManager.isAuthenticated).will.beTruthy();
//  expect(self.testSessionManager.oauthToken).willNot.beNil;
//
//  PKTOAuth2Token *token = self.testSessionManager.oauthToken;
//
//  [self.testSessionManager refreshSessionToken:nil];
//
//  expect(self.testSessionManager.isAuthenticated).will.beTruthy();
//  expect(self.testSessionManager.oauthToken.accessToken).will.equal(token.accessToken);
//  expect(self.testSessionManager.oauthToken.refreshToken).will.equal(token.refreshToken);
//  expect(self.testSessionManager.oauthToken.refData).will.equal(token.refData);
//  expect(self.testSessionManager.oauthToken.expiresOn).willNot.equal(token.expiresOn);
//}

@end
