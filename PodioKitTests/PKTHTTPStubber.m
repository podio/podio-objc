//
//  PKTHTTPStubber.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <OHHTTPStubs/OHHTTPStubs.h>
#import "PKTHTTPStubber.h"

@interface PKTHTTPStubber ()

@end

@implementation PKTHTTPStubber

- (instancetype)initWithPath:(NSString *)path {
  self = [super init];
  if (!self) return nil;
  
  _path = [path copy];
  _statusCode = 200;
  _requestTime = -1;
  _responseTime = -1;
  
  return self;
}

+ (instancetype)stubberForPath:(NSString *)path {
  return [[self alloc] initWithPath:path];
}

#pragma mark - Public

- (void)stub {
  [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
    return [[[request URL] path] isEqualToString:self.path];
  } withStubResponse:^OHHTTPStubsResponse *(NSURLRequest *request) {
    return [self makeResponse];
  }];
}

#pragma mark - Private

- (OHHTTPStubsResponse *)makeResponse {
  OHHTTPStubsResponse *response = nil;
  
  if (self.error) {
    [OHHTTPStubsResponse responseWithError:self.error];
  } else {
    NSDictionary *headers = nil;
    NSData *data = nil;
    if (self.responseObject) {
      headers = @{@"Content-Type": @"application/json; charset=utf-8"};
      data = [NSJSONSerialization dataWithJSONObject:self.responseObject options:0 error:NULL];
    } else {
      data = [NSData data];
    }
    
    response = [OHHTTPStubsResponse responseWithData:data statusCode:self.statusCode headers:headers];
  }
  
  if (self.requestTime >= 0) {
    response.requestTime = self.requestTime;
  }
  
  if (self.responseTime >= 0) {
    response.responseTime = self.responseTime;
  }
  
  return response;
}

@end
