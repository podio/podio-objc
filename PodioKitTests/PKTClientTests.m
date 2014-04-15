//
//  PKTClientTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTStubs.h"
#import "PKTClient.h"
#import "PKTRequest.h"
#import "PKTResponse.h"

static NSString * const kAPIKey = @"test-key";
static NSString * const kAPISecret = @"test-secret";

@interface PKTClientTests : XCTestCase

@property (nonatomic, strong) PKTClient *testClient;

@end

@implementation PKTClientTests

- (void)setUp {
  [super setUp];
  self.testClient = [[PKTClient alloc] initWithAPIKey:kAPIKey secret:kAPISecret];
}

- (void)tearDown {
  self.testClient = nil;
  [Expecta setAsynchronousTestTimeout:1];
  [super tearDown];
}

#pragma mark - Tests

- (void)testInit {
  PKTClient *client = [[PKTClient alloc] initWithAPIKey:kAPIKey secret:kAPISecret];

  expect(client.apiKey).to.equal(kAPIKey);
  expect(client.apiSecret).to.equal(kAPISecret);
  expect([client.baseURL absoluteString]).to.equal(@"https://api.podio.com");
}

- (void)testSetupClient {
  PKTClient *client = [PKTClient new];
  [client setupWithAPIKey:kAPIKey secret:kAPISecret];
  
  expect(client.apiKey).to.equal(kAPIKey);
  expect(client.apiSecret).to.equal(kAPISecret);
  expect([client.baseURL absoluteString]).to.equal(@"https://api.podio.com");
}

- (void)testSharedInstance {
  expect([PKTClient sharedClient]).to.equal([PKTClient sharedClient]);
}

- (void)testPerformSuccessfulRequest {
  NSString *path = @"/user/status";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  stubResponseWithStatusCode(path, 200);

  __block BOOL completed = NO;
  NSURLSessionTask *task = [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    if (!error) {
      completed = YES;
    }
  }];

  expect(task).notTo.beNil();
  expect(completed).will.beTruthy();
}

- (void)testPerformUnsuccessfulRequest {
  NSString *path = @"/user/status";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  stubResponseWithStatusCode(path, 500);

  __block BOOL errorOccured = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    if (error) {
      errorOccured = YES;
    }
  }];

  expect(errorOccured).will.beTruthy();
}

- (void)testTimeoutRequest {
  NSString *path = @"/user/status";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  [Expecta setAsynchronousTestTimeout:5];
  stubResponseWithTime(path, 2, 0);

  __block BOOL completed = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    completed = YES;
  }];

  expect(completed).will.beFalsy();
}

- (void)testCancelRequest {
  NSString *path = @"/user/status";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  [Expecta setAsynchronousTestTimeout:5];
  stubResponseWithTime(path, 5, 0);

  __block BOOL cancelled = NO;
  NSURLSessionTask *task = [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    if (error.code == NSURLErrorCancelled) {
      cancelled = YES;
    }
  }];

  expect(task).notTo.beNil();

  [task cancel];

  expect(cancelled).will.beTruthy();
}

- (void)testSuspendRequest {
  NSString *path = @"/user/status";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  [Expecta setAsynchronousTestTimeout:5];
  stubResponseWithTime(path, 5, 0);

  __block BOOL completed = NO;
  NSURLSessionTask *task = [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    completed = YES;
  }];

  expect(task).notTo.beNil();

  [task suspend];

  expect(completed).will.beFalsy();
}

- (void)testResumeRequest {
  NSString *path = @"/user/status";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  [Expecta setAsynchronousTestTimeout:5];
  stubResponseWithTime(path, 5, 0);

  __block BOOL completed = NO;
  NSURLSessionTask *task = [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    completed = YES;
  }];

  expect(task).notTo.beNil();

  [task suspend];

  expect(completed).will.beFalsy();

  wait(10);

  [task resume];

  expect(completed).will.beTruthy();
}

- (void)testSetCustomHeader {
  [self.testClient setValue:@"Header value" forHTTPHeader:@"X-Test-Header"];
  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"X-Test-Header"]).to.equal(@"Header value");
}

- (void)testSetAuthorizationHeaderWithAPICredentials {
  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"]).to.beNil;

  [self.testClient setAuthorizationHeaderWithAPICredentials];

  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"]).to.contain(@"Basic ");
  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"]).notTo.contain(self.testClient.apiKey);
  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"]).notTo.contain(self.testClient.apiSecret);
  expect([self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"] length]).to.beGreaterThan([@"Basic " length]);
}

- (void)testSetAuthorizationHeaderWithOAuth2AccessToken {
  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"]).to.beNil;

  NSString *accessToken = @"anAccessToken";
  [self.testClient setAuthorizationHeaderWithOAuth2AccessToken:accessToken];

  NSString *expectedHTTPHeader = [NSString stringWithFormat:@"OAuth2 %@", accessToken];
  expect(self.testClient.requestSerializer.HTTPRequestHeaders[@"Authorization"]).to.contain(expectedHTTPHeader);
}

@end
