
//
//  PKTRequest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequest.h"

@implementation PKTRequest

- (instancetype)initWithPath:(NSString *)path url:(NSURL *)url parameters:(NSDictionary *)parameters method:(PKTRequestMethod)method {
  self = [super init];
  if (!self) return nil;
  
  _path = [path copy];
  _URL = [url copy];
  _parameters = [parameters copy];
  _method = method;
  
  return self;
}

+ (instancetype)requestWithPath:(NSString *)path parameters:(NSDictionary *)parameters method:(PKTRequestMethod)method {
  return [[self alloc] initWithPath:path url:nil parameters:parameters method:method];
}

+ (instancetype)requestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters method:(PKTRequestMethod)method {
  return [[self alloc] initWithPath:nil url:url parameters:parameters method:method];
}

+ (instancetype)GETRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self requestWithPath:path parameters:parameters method:PKTRequestMethodGET];
}

+ (instancetype)POSTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self requestWithPath:path parameters:parameters method:PKTRequestMethodPOST];
}

+ (instancetype)PUTRequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self requestWithPath:path parameters:parameters method:PKTRequestMethodPUT];
}

+ (instancetype)DELETERequestWithPath:(NSString *)path parameters:(NSDictionary *)parameters {
  return [self requestWithPath:path parameters:parameters method:PKTRequestMethodDELETE];
}

+ (instancetype)GETRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters {
  return [self requestWithURL:url parameters:parameters method:PKTRequestMethodGET];
}

+ (instancetype)POSTRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters {
  return [self requestWithURL:url parameters:parameters method:PKTRequestMethodPOST];
}

+ (instancetype)PUTRequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters {
  return [self requestWithURL:url parameters:parameters method:PKTRequestMethodPUT];
}

+ (instancetype)DELETERequestWithURL:(NSURL *)url parameters:(NSDictionary *)parameters {
  return [self requestWithURL:url parameters:parameters method:PKTRequestMethodDELETE];
}

@end
