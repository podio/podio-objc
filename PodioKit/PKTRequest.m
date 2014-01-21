
//
//  PKTRequest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequest.h"

@implementation PKTRequest

- (instancetype)initWithPath:(NSString *)path method:(PKTRequestMethod)method {
  self = [super init];
  if (!self) return nil;
  
  _path = [path copy];
  _method = method;
  
  return self;
}

+ (instancetype)requestWithPath:(NSString *)path method:(PKTRequestMethod)method {
  return [[self alloc] initWithPath:path method:method];
}

+ (instancetype)GETRequestWithPath:(NSString *)path {
  return [self requestWithPath:path method:PKTRequestMethodGET];
}

+ (instancetype)POSTRequestWithPath:(NSString *)path {
  return [self requestWithPath:path method:PKTRequestMethodPOST];
}

+ (instancetype)PUTRequestWithPath:(NSString *)path {
  return [self requestWithPath:path method:PKTRequestMethodPUT];
}

+ (instancetype)DELETERequestWithPath:(NSString *)path {
  return [self requestWithPath:path method:PKTRequestMethodDELETE];
}

@end
