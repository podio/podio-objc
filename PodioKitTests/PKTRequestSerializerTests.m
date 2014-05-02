//
//  PKTRequestSerializerTests.m
//  PodioKit
//
//  Created by Romain Briche on 29/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTRequestSerializer.h"
#import "PKTRequest.h"
#import "NSURL+PKTParamatersHandling.h"

@interface PKTRequestSerializerTests : XCTestCase

@property (nonatomic, copy) PKTRequestSerializer *testSerializer;
@property (nonatomic, copy) NSURL *baseURL;

@end

@implementation PKTRequestSerializerTests

- (void)setUp {
  [super setUp];
  self.testSerializer = [PKTRequestSerializer new];
  self.baseURL = [[NSURL alloc] initWithString:@"https://api.podio.com"];
}

- (void)tearDown {
  self.testSerializer = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testSetAuthorizationHeaderFieldWithOAuth2AccessToken {
  NSString *accessToken = @"aToken";

  PKTRequestSerializer *requestSerializer = [PKTRequestSerializer serializer];
  [requestSerializer setAuthorizationHeaderFieldWithOAuth2AccessToken:accessToken];

  NSString *expectedHTTPHeader = [NSString stringWithFormat:@"OAuth2 %@", accessToken];
  expect(requestSerializer.HTTPRequestHeaders[@"Authorization"]).to.equal(expectedHTTPHeader);
}

- (void)testURLRequestForGETRequest {
  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  NSURLRequest *urlRequest = [self.testSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  expect(urlRequest.URL.path).to.equal(request.path);
  expect(urlRequest.HTTPMethod).to.equal(@"GET");
  expect([[urlRequest URL] pkt_queryParameters]).to.pkt_beSupersetOf(request.parameters);
  expect([[urlRequest allHTTPHeaderFields][@"X-Podio-Request-Id"] length]).to.beGreaterThan(0);
}

- (void)testURLRequestForPOSTRequest {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];

  NSURLRequest *urlRequest = [self.testSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
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

  NSURLRequest *urlRequest = [self.testSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
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

  NSURLRequest *urlRequest = [self.testSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  expect(urlRequest.URL.path).to.equal(request.path);
  expect(urlRequest.HTTPMethod).to.equal(@"DELETE");
  expect([[urlRequest URL] pkt_queryParameters]).to.pkt_beSupersetOf(request.parameters);
  expect([[urlRequest allHTTPHeaderFields][@"X-Podio-Request-Id"] length]).to.beGreaterThan(0);
}

- (void)testFormURLEncodedRequest {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/some/path" parameters:@{@"param1": @"someValue", @"param2": @"someOtherValue"}];
  request.contentType = PKTRequestContentTypeFormURLEncoded;
  
  NSURLRequest *urlRequest = [self.testSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  NSString *bodyString = [[NSString alloc] initWithData:urlRequest.HTTPBody encoding:NSUTF8StringEncoding];
  expect(bodyString).to.equal(@"param1=someValue&param2=someOtherValue");
}

- (void)testMultipartRequest {
  PKTRequest *request = [PKTRequest POSTRequestWithPath:@"/some/path" parameters:@{@"param1" : @"someValue"}];
  request.contentType = PKTRequestContentTypeMultipart;
  request.fileData = [PKTRequestFileData fileDataWithData:[NSData data] name:@"name" fileName:@"image.jpg" mimeType:@"image/jpeg"];
  
  NSURLRequest *urlRequest = [self.testSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  expect(urlRequest.allHTTPHeaderFields[@"Content-Type"]).to.contain(@"multipart/form-data");
}

@end
