//
//  PKTSessionManagerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "PKTClient.h"
#import "PKTHTTPClient.h"
#import "PKTOAuth2Token.h"
#import "PKTClient+Test.h"

@interface PKTClientTests : XCTestCase

@property (nonatomic, strong) PKTClient *testClient;

@end

@implementation PKTClientTests

- (void)setUp {
  [super setUp];
  self.testClient = [PKTClient new];

  
  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [request.URL.host isEqualToString:self.testClient.HTTPClient.baseURL.host];
  } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
    return [OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil];
  }];
}

- (void)tearDown {
  self.testClient = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testSharedInstance {
  expect([PKTClient sharedClient]).to.equal([PKTClient sharedClient]);
}

- (void)testInitWithClient {
  PKTHTTPClient *httpClient = [PKTHTTPClient new];
  PKTClient *client = [[PKTClient alloc] initWithHTTPClient:httpClient];
  expect(client.HTTPClient).to.equal(httpClient);
  expect(client.oauthToken).to.beNil();
  expect(client.isAuthenticated).to.beFalsy();
}

- (void)testSetupWithAPIKeyAndSecret {
  PKTClient *client = [PKTClient new];
  expect(client.apiKey).to.beNil();
  expect(client.apiSecret).to.beNil();
  
  [client setupWithAPIKey:@"my-key" secret:@"my-secret"];
  expect(client.apiKey).to.equal(@"my-key");
  expect(client.apiSecret).to.equal(@"my-secret");
}

- (void)testSetOAuthToken {
  PKTClient *client = [PKTClient new];
  
  NSDictionary *tokenDict = @{
    @"access_token" : @"abc123",
    @"refresh_token" : @"abc123",
    @"expires_in" : @3600,
    @"ref" : [NSNull null]
  };
  
  PKTOAuth2Token *token = [[PKTOAuth2Token alloc] initWithDictionary:tokenDict];
  client.oauthToken = token;
  
  expect(client.oauthToken).to.equal(token);
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
