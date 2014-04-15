//
//  PKTStubs.h
//  PodioKit
//
//  Created by Romain Briche on 30/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OHHTTPStubs/OHHTTPStubs.h>

void (^stubResponseFromFile)(NSString *, NSString *) = ^(NSString *path, NSString *responseFilename) {
  NSDictionary *headers = @{@"Content-Type": @"application/json; charset=utf-8"};

	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
		return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInDocumentsDir(responseFilename) statusCode:200 headers:headers];
  }];
};

void (^stubResponseFromObject)(NSString *, id) = ^(NSString *path, id responseObject) {
  NSDictionary *headers = @{@"Content-Type": @"application/json; charset=utf-8"};

	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL];
		return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:headers];
  }];
};

void (^stubResponseWithStatusCode)(NSString *, int) = ^(NSString *path, int statusCode) {
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
		return [OHHTTPStubsResponse responseWithData:[NSData data] statusCode:statusCode headers:nil];
  }];
};

void (^stubResponseWithTime)(NSString *, int, int) = ^(NSString *path, int requestTime, int responseTime) {
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
		return [[OHHTTPStubsResponse responseWithData:[NSData data] statusCode:200 headers:nil] requestTime:requestTime responseTime:responseTime];
  }];
};
