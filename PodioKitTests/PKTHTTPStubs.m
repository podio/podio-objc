//
//  PKTHTTPStubs.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "PKTHTTPStubs.h"

@implementation PKTHTTPStubs

+ (void)stubResponseForPath:(NSString *)path responseFilename:(NSString *)responseFilename {
  NSDictionary *headers = @{@"Content-Type": @"application/json; charset=utf-8"};
  
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
		return [OHHTTPStubsResponse responseWithFileAtPath:OHPathForFileInDocumentsDir(responseFilename) statusCode:200 headers:headers];
  }];
}

+ (void)stubResponseForPath:(NSString *)path responseObject:(id)responseObject {
  NSDictionary *headers = @{@"Content-Type": @"application/json; charset=utf-8"};
  
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:NULL];
		return [OHHTTPStubsResponse responseWithData:data statusCode:200 headers:headers];
  }];
}

+ (void)stubResponseForPath:(NSString *)path statusCode:(int)statusCode {
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
		return [OHHTTPStubsResponse responseWithData:[NSData data] statusCode:statusCode headers:nil];
  }];
}

+ (void)stubResponseForPath:(NSString *)path requestTime:(int)requestTime responseTime:(int)responseTime {
	[OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
		return [[OHHTTPStubsResponse responseWithData:[NSData data] statusCode:200 headers:nil] requestTime:requestTime responseTime:responseTime];
  }];
}

+ (void)stubNetworkDownForPath:(NSString *)path {
  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
    NSError *error = [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:nil];
		return [OHHTTPStubsResponse responseWithError:error];
  }];
}

@end
