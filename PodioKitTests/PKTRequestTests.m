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
  PKTRequest *request = [PKTRequest GETRequestWithPath:path];
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(path);
}

- (void)testPOSTRequest {
  NSString *path = @"/some/path";
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path];
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(path);
}

- (void)testPUTRequest {
  NSString *path = @"/some/path";
  PKTRequest *request = [PKTRequest PUTRequestWithPath:path];
  expect(request.method).to.equal(PKTRequestMethodPUT);
  expect(request.path).to.equal(path);
}

- (void)testDELETERequest {
  NSString *path = @"/some/path";
  PKTRequest *request = [PKTRequest DELETERequestWithPath:path];
  expect(request.method).to.equal(PKTRequestMethodDELETE);
  expect(request.path).to.equal(path);
}

@end
