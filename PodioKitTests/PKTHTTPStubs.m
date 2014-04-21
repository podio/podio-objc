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

+ (void)stubResponseForPath:(NSString *)path block:(void (^)(PKTHTTPStubber *stubber))block {
  PKTHTTPStubber *stubber = [PKTHTTPStubber stubberForPath:path];
  
  if (block) block(stubber);
  
  [stubber stub];
}

+ (void)stubResponseForPath:(NSString *)path responseObject:(id)responseObject {
  return [self stubResponseForPath:path block:^(PKTHTTPStubber *stubber) {
    stubber.responseObject = responseObject;
  }];
}

+ (void)stubResponseForPath:(NSString *)path statusCode:(int)statusCode {
  return [self stubResponseForPath:path block:^(PKTHTTPStubber *stubber) {
    stubber.statusCode = statusCode;
  }];
}

+ (void)stubResponseForPath:(NSString *)path requestTime:(int)requestTime responseTime:(int)responseTime {
  return [self stubResponseForPath:path block:^(PKTHTTPStubber *stubber) {
    stubber.requestTime = requestTime;
    stubber.responseTime = responseTime;
  }];
}

+ (void)stubNetworkDownForPath:(NSString *)path {
  return [self stubResponseForPath:path block:^(PKTHTTPStubber *stubber) {
    stubber.error = [NSError errorWithDomain:NSURLErrorDomain code:kCFURLErrorNotConnectedToInternet userInfo:nil];
  }];
}

@end
