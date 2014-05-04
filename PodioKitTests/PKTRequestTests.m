//
//  PKTRequestTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTRequest.h"

@interface PKTRequestTests : XCTestCase

@end

@implementation PKTRequestTests

- (void)testGETRequest {
  NSString *path = @"/some/path";
  NSDictionary *params = @{@"param1": @"someValue", @"param2": @"someOtherValue"};
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:params];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(path);
  expect(request.parameters).to.equal(params);
}

- (void)testPOSTRequest {
  NSString *path = @"/some/path";
  NSDictionary *params = @{@"param1": @"someValue", @"param2": @"someOtherValue"};
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:params];
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(path);
  expect(request.parameters).to.equal(params);
}

- (void)testPUTRequest {
  NSString *path = @"/some/path";
  NSDictionary *params = @{@"param1": @"someValue", @"param2": @"someOtherValue"};
  PKTRequest *request = [PKTRequest PUTRequestWithPath:path parameters:params];
  expect(request.method).to.equal(PKTRequestMethodPUT);
  expect(request.path).to.equal(path);
}

- (void)testDELETERequest {
  NSString *path = @"/some/path";
  NSDictionary *params = @{@"param1": @"someValue", @"param2": @"someOtherValue"};
  PKTRequest *request = [PKTRequest DELETERequestWithPath:path parameters:params];
  expect(request.method).to.equal(PKTRequestMethodDELETE);
  expect(request.path).to.equal(path);
  expect(request.parameters).to.equal(params);
}

@end
