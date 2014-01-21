//
//  PKTClientTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "PKTAsyncTestCase.h"
#import "PKTClient.h"
#import "PKTRequest.h"
#import "PKTResponse.h"
#import "PKTClient+Test.h"

static NSString * const kAPIKey = @"test-key";
static NSString * const kAPISecret = @"test-secret";

@interface PKTClientTests : PKTAsyncTestCase

@property (nonatomic, strong) PKTClient *testClient;

@end

@implementation PKTClientTests

- (void)setUp {
  [super setUp];
  self.testClient = [[PKTClient alloc] initWithAPIKey:kAPIKey secret:kAPISecret];
}

- (void)tearDown {
  self.testClient = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testInit {
  PKTClient *client = [[PKTClient alloc] initWithAPIKey:kAPISecret secret:kAPISecret];

  expect(client.apiKey).to.equal(kAPISecret);
  expect(client.apiSecret).to.equal(kAPISecret);
  expect([client.baseURL absoluteString]).to.equal(@"https://api.podio.com");
}

- (void)testPerformSuccessfulRequest {
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/user/status"];

  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [request.URL.host isEqualToString:self.testClient.baseURL.host];
  } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
    return [OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil];
  }];
  
  __block BOOL completed = NO;
  [self waitForCompletionWithBlock:^{
    [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
      completed = YES;
      [self finish];
    }];
  }];
  
  expect(completed).to.beTruthy();
}

- (void)testHTTPMethod {
  expect([PKTClient HTTPMethodForMethod:PKTRequestMethodGET]).to.equal(@"GET");
  expect([PKTClient HTTPMethodForMethod:PKTRequestMethodPOST]).to.equal(@"POST");
  expect([PKTClient HTTPMethodForMethod:PKTRequestMethodPUT]).to.equal(@"PUT");
  expect([PKTClient HTTPMethodForMethod:PKTRequestMethodDELETE]).to.equal(@"DELETE");
}

- (void)testURLRequestForRequest {
  NSString *path = @"/some/path";
  PKTRequest *request = [PKTRequest GETRequestWithPath:path];
  
  NSURLRequest *urlRequest = [self.testClient URLRequestForRequest:request];
  expect(urlRequest.URL.path).to.equal(path);
  expect(urlRequest.HTTPMethod).to.equal(@"GET");
  
  // TODO: Check parameters
}

@end
