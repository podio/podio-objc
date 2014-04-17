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
#import "PKTAuthenticationAPI.h"
#import "PKTUserAPI.h"
#import "PKTRequest.h"
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
  
  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubResponseForPath:request.path responseObject:tokenDict];
  
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
  
  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:401];
  
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
  
  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubNetworkDownForPath:request.path];
  
  __block BOOL completed = NO;
  [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).to.equal(initialToken);
}

- (void)testRequestWithExpiredTokenShouldFinishAfterSuccessfulTokenRefresh {
  // Make sure the current token is expired
  PKTOAuth2Token *expiredToken = [self dummyAuthTokenWithExpirationSinceNow:-600]; // Expired 10 minutes ago
  self.testClient.oauthToken = expiredToken;
  
  // Return a refreshed token
  NSDictionary *refreshedTokenDict = [self dummyAuthTokenDictWithExpirationSinceNow:3600]; // Expires in 1h
  PKTRequest *refreshRequest = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubResponseForPath:refreshRequest.path responseObject:refreshedTokenDict];
  
  // Make a normal request that should finish after the refresh
  PKTRequest *request = [PKTUserAPI requestForUserStatus];
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).toNot.equal(expiredToken);
  expect([self.testClient.oauthToken willExpireWithinIntervalFromNow:10]).to.beFalsy();
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
  return [self dummyAuthTokenDictWithExpirationSinceNow:3600];
}

- (NSDictionary *)dummyAuthTokenDictWithExpirationSinceNow:(NSTimeInterval)expiration {
  return @{
    @"access_token" : @"abc123",
    @"refresh_token" : @"abc123",
    @"expires_in" : @(expiration),
    @"ref" : @{@"key": @"value"}
  };
}

- (PKTOAuth2Token *)dummyAuthToken {
  return [self dummyAuthTokenWithExpirationSinceNow:3600];
}

- (PKTOAuth2Token *)dummyAuthTokenWithExpirationSinceNow:(NSTimeInterval)expiration {
  NSDictionary *dict = [self dummyAuthTokenDictWithExpirationSinceNow:expiration];
  PKTOAuth2Token *token = [[PKTOAuth2Token alloc] initWithDictionary:dict];
  
  return token;
}

@end
