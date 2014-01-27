//
//  PKTClientTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <OHHTTPStubs/OHHTTPStubs.h>
#import "PKTClient.h"
#import "PKTRequest.h"
#import "PKTResponse.h"
#import "PKTClient+Test.h"
#import "NSURL+PKTParamatersHandling.h"

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
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/user/status" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [request.URL.host isEqualToString:self.testClient.baseURL.host];
  } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
    return [OHHTTPStubsResponse responseWithData:nil statusCode:200 headers:nil];
  }];
  
  __block BOOL completed = NO;
  [self.testClient performRequest:request completion:^(PKTResponse *result, NSError *error) {
    completed = YES;
  }];

  expect(completed).will.beTruthy();
}

- (void)testURLRequestForGETRequest {
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];
  
  NSURLRequest *urlRequest = [self.testClient URLRequestForRequest:request];
  expect(urlRequest.URL.path).to.equal(request.path);
  expect(urlRequest.HTTPMethod).to.equal(@"GET");
  expect([[urlRequest URL] pkt_queryParameters]).to.pkt_beSupersetOf(request.parameters);
  expect([[urlRequest allHTTPHeaderFields][@"X-Podio-Request-Id"] length]).to.beGreaterThan(0);
}

- (void)testURLRequestForPOSTRequest {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  NSURLRequest *urlRequest = [self.testClient URLRequestForRequest:request];
  expect(urlRequest.URL.path).to.equal(request.path);
  expect(urlRequest.HTTPMethod).to.equal(@"POST");

  NSError *error = nil;
  id bodyParameters = [NSJSONSerialization JSONObjectWithData:[urlRequest HTTPBody] options:0 error:&error];
  bodyParameters = [NSDictionary dictionaryWithDictionary:bodyParameters];
  expect(bodyParameters).to.pkt_beSupersetOf(request.parameters);
  expect([[urlRequest allHTTPHeaderFields][@"X-Podio-Request-Id"] length]).to.beGreaterThan(0);
  expect([urlRequest allHTTPHeaderFields][@"Content-Type"]).to.equal(@"application/json; charset=utf-8");
}

- (void)testURLRequestForPUTRequest {
  PKTRequest *request = [PKTRequest PUTRequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  NSURLRequest *urlRequest = [self.testClient URLRequestForRequest:request];
  expect(urlRequest.URL.path).to.equal(request.path);
  expect(urlRequest.HTTPMethod).to.equal(@"PUT");

  NSError *error = nil;
  NSDictionary *bodyParameters = [[NSJSONSerialization JSONObjectWithData:[urlRequest HTTPBody] options:0 error:&error] copy];
  bodyParameters = [NSDictionary dictionaryWithDictionary:bodyParameters];
  expect(bodyParameters).to.pkt_beSupersetOf(request.parameters);
  expect([[urlRequest allHTTPHeaderFields][@"X-Podio-Request-Id"] length]).to.beGreaterThan(0);
  expect([urlRequest allHTTPHeaderFields][@"Content-Type"]).to.equal(@"application/json; charset=utf-8");
}

- (void)testURLRequestForDELETERequest {
  PKTRequest *request = [PKTRequest DELETERequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  NSURLRequest *urlRequest = [self.testClient URLRequestForRequest:request];
  expect(urlRequest.URL.path).to.equal(request.path);
  expect(urlRequest.HTTPMethod).to.equal(@"DELETE");
  expect([[urlRequest URL] pkt_queryParameters]).to.pkt_beSupersetOf(request.parameters);
  expect([[urlRequest allHTTPHeaderFields][@"X-Podio-Request-Id"] length]).to.beGreaterThan(0);
}

- (void)testSetCustomHeader {
  PKTRequest *request = [PKTRequest PUTRequestWithPath:@"/some/path" parameters:nil];
  
  [self.testClient setValue:@"Header value" forHTTPHeader:@"X-Test-Header"];
  NSURLRequest *urlRequest = [self.testClient URLRequestForRequest:request];
  expect([urlRequest allHTTPHeaderFields][@"X-Test-Header"]).to.equal(@"Header value");
}

@end
