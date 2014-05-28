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
  AFHTTPRequestOperation *operation = [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(operation).notTo.beNil();
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
  AFHTTPRequestOperation *operation = [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(operation).notTo.beNil();
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).to.beNil();
}

- (void)testTokenShouldBeSameAfterFailedRefreshDueToNoInternet {
  PKTOAuth2Token *initialToken = [self dummyAuthToken];
  self.testClient.oauthToken = initialToken;
  
  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubNetworkDownForPath:request.path];
  
  __block BOOL completed = NO;
  AFHTTPRequestOperation *operation = [self.testClient refreshToken:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(operation).notTo.beNil();
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).to.equal(initialToken);
}

- (void)testMultipleRequestsWithExpiredTokenShouldFinishAfterSuccessfulTokenRefresh {
  // Make sure the current token is expired
  PKTOAuth2Token *expiredToken = [self dummyAuthTokenWithExpirationSinceNow:-600]; // Expired 10 minutes ago
  self.testClient.oauthToken = expiredToken;
  
  // Return a refreshed token
  NSDictionary *refreshedTokenDict = [self dummyAuthTokenDictWithExpirationSinceNow:3600]; // Expires in 1h
  PKTRequest *refreshRequest = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubResponseForPath:refreshRequest.path responseObject:refreshedTokenDict];
  
  // Make a normal request that should finish after the refresh
  PKTRequest *request = [PKTUserAPI requestForUserStatus];
  
  // Make 1st request
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed1 = NO;
  __block BOOL isError1 = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed1 = YES;
    isError1 = error != nil;
  }];

  expect(completed1).will.beTruthy();
  expect(isError1).to.beFalsy();
  
  // Make 2nd request
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed2 = NO;
  __block BOOL isError2 = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed2 = YES;
    isError2 = error != nil;
  }];
  
  expect(completed2).will.beTruthy();
  expect(isError2).to.beFalsy();
  
  expect(self.testClient.oauthToken).toNot.equal(expiredToken);
  expect([self.testClient.oauthToken willExpireWithinIntervalFromNow:10]).to.beFalsy();
}

- (void)testMultipleRequestsWithExpiredTokenShouldFailAfterRefreshFailed {
  // Make sure the current token is expired
  PKTOAuth2Token *expiredToken = [self dummyAuthTokenWithExpirationSinceNow:-600]; // Expired 10 minutes ago
  self.testClient.oauthToken = expiredToken;
  
  // Return a 401, failed to refresh token
  PKTRequest *refreshRequest = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubResponseForPath:refreshRequest.path statusCode:401];
  
  // Make a normal request that should fail after the failed refresh
  PKTRequest *request = [PKTUserAPI requestForUserStatus];
  
  // Make 1st request
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed1 = NO;
  __block BOOL isCancelError1 = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed1 = YES;
    isCancelError1 = error != nil && error.code == NSURLErrorCancelled;
  }];
  
  // Make 2nd request
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed2 = NO;
  __block BOOL isCancelError2 = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed2 = YES;
    isCancelError2 = error != nil && error.code == NSURLErrorCancelled;
  }];
  
  expect(completed1).will.beTruthy();
  expect(isCancelError1).to.beTruthy();
  
  expect(completed2).will.beTruthy();
  expect(isCancelError2).to.beTruthy();
}

- (void)testTaskShouldHaveUpdatedAuthorizationHeaderAfterSuccessfulTokenRefresh {
  // Make sure the current token is expired
  PKTOAuth2Token *expiredToken = [self dummyAuthTokenWithExpirationSinceNow:-600]; // Expired 10 minutes ago
  self.testClient.oauthToken = expiredToken;
  
  // Return a refreshed token
  NSMutableDictionary *refreshedTokenDict = [[self dummyAuthTokenDictWithExpirationSinceNow:3600] mutableCopy]; // Expires in 1h
  refreshedTokenDict[@"access_token"] = @"new_access_token";
  
  PKTRequest *refreshRequest = [PKTAuthenticationAPI requestToRefreshToken:self.testClient.oauthToken.refreshToken];
  [PKTHTTPStubs stubResponseForPath:refreshRequest.path responseObject:refreshedTokenDict];
  
  // Make a normal request that should fail after the failed refresh
  PKTRequest *request = [PKTUserAPI requestForUserStatus];
  
  // Make 1st request
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed = NO;
  AFHTTPRequestOperation *operation = [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  NSString *firstHeader = [operation.request valueForHTTPHeaderField:@"Authorization"];

  expect(completed).will.beTruthy();
  
  NSString *secondHeader = [operation.request valueForHTTPHeaderField:@"Authorization"];
  expect(secondHeader).toNot.equal(firstHeader);
}

- (void)testAuthenticationWithEmailAndPassword {
  NSDictionary *tokenDict = [self dummyAuthTokenDict];
  PKTRequest *authRequest = [PKTAuthenticationAPI requestForAuthenticationWithEmail:@"me@domain.com" password:@"p4$$w0rD"];
  [PKTHTTPStubs stubResponseForPath:authRequest.path responseObject:tokenDict];
  
  __block BOOL completed = NO;
  [self.testClient authenticateAsAppWithID:1234 token:@"app-token" completion:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).toNot.beNil();
}

- (void)testAuthenticationWithAppIDAndToken {
  NSDictionary *tokenDict = [self dummyAuthTokenDict];
  PKTRequest *authRequest = [PKTAuthenticationAPI requestForAuthenticationWithAppID:1234 token:@"app-token"];
  [PKTHTTPStubs stubResponseForPath:authRequest.path responseObject:tokenDict];
  
  __block BOOL completed = NO;
  [self.testClient authenticateAsAppWithID:1234 token:@"app-token" completion:^(PKTResponse *response, NSError *error) {
    completed = YES;
  }];
  
  expect(completed).will.beTruthy();
  expect(self.testClient.oauthToken).toNot.beNil();
}

- (void)testAuthenticateAutomaticallyWithApp {
  [self.testClient authenticateAutomaticallyAsAppWithID:1234 token:@"app-token"];
  
  NSDictionary *tokenDict = [self dummyAuthTokenDict];
  PKTRequest *authRequest = [PKTAuthenticationAPI requestForAuthenticationWithAppID:1234 token:@"app-token"];
  [PKTHTTPStubs stubResponseForPath:authRequest.path responseObject:tokenDict];
  
  PKTRequest *request = [PKTUserAPI requestForUserStatus];
  [PKTHTTPStubs stubResponseForPath:request.path statusCode:200];
  
  __block BOOL completed = NO;
  __block BOOL isError = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *response, NSError *error) {
    completed = YES;
    isError = error != nil;
  }];
  
  expect(completed).will.beTruthy();
  expect(isError).to.beFalsy();
  expect(self.testClient.oauthToken).toNot.beNil();
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

- (void)testAuthenticationStateNotificationSentOnTokenChange {
  expect(^{
    self.testClient.oauthToken = [self dummyAuthToken];
  }).to.notify(PKTClientAuthenticationStateDidChangeNotification);
}

@end
