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
#import "PKTHTTPStubs.h"
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
  
  PKTOAuth2Token *token = [self dummyAuthToken];
  client.oauthToken = token;
  
  expect(client.oauthToken).to.equal(token);
}

- (void)testSuccessfulRefreshTokenReplacesToken {
  PKTOAuth2Token *initialToken = [self dummyAuthToken];
  self.testClient.oauthToken = initialToken;
  
  NSDictionary *tokenDict = [self dummyAuthTokenDict];
  [PKTHTTPStubs stubResponseForPath:@"/oauth/token" responseObject:tokenDict];
  
  __block BOOL completed = NO;
  [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.isAuthenticated).to.beTruthy();
  expect(self.testClient.oauthToken).notTo.equal(initialToken);
}

- (void)testTokenShouldBeNilAfterFailedRefreshDueToServerSideError {
  PKTOAuth2Token *initialToken = [self dummyAuthToken];
  self.testClient.oauthToken = initialToken;
  
  [PKTHTTPStubs stubResponseForPath:@"/oauth/token" statusCode:401];
  
  __block BOOL completed = NO;
  [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).to.beNil();
}

- (void)testTokenShouldBeSameAfterFailedRefreshDueToNoInternet {
  PKTOAuth2Token *initialToken = [self dummyAuthToken];
  self.testClient.oauthToken = initialToken;
  
  [PKTHTTPStubs stubNetworkDownForPath:@"/oauth/token"];
  
  __block BOOL completed = NO;
  [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).to.equal(initialToken);
}

- (void)testRequestWithExpiredTokenShouldFinishAfterSuccessfulTokenRefresh {

}

- (void)testMultipleRequestsWithExpiredTokenShouldFinishAfterSuccessfulTokenRefresh {

}

- (void)testRequestWithExpiredTokenShouldErrorAfterFailedTokenRefresh {
  
}

- (void)testMultipleRequestsWithExpiredTokenShouldFinishAfterSuccessfulRefresh {
  
}

- (void)testTaskShouldHaveUpdatedAuthorizationHeaderAfterSuccessfulTokenRefresh {

}

- (void)testAuthenticationWithEmailAndPassword {

}

- (void)testAuthenticationWithAppIDAndToken {

}

#pragma mark - Helpers

- (NSDictionary *)dummyAuthTokenDict {
  return @{
    @"access_token" : @"abc123",
    @"refresh_token" : @"abc123",
    @"expires_in" : @3600,
    @"ref" : @{@"key": @"value"}
  };
}

- (PKTOAuth2Token *)dummyAuthToken {
  return [[PKTOAuth2Token alloc] initWithDictionary:[self dummyAuthTokenDict]];
}

@end
