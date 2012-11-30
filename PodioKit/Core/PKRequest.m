//
//  PKRequest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKRequest.h"
#import "PKObjectMapping.h"
#import "PKRequestOperation.h"
#import "PKRequestManager.h"

PKRequestMethod const PKRequestMethodGET = @"GET";
PKRequestMethod const PKRequestMethodPOST = @"POST";
PKRequestMethod const PKRequestMethodPUT = @"PUT";
PKRequestMethod const PKRequestMethodDELETE = @"DELETE";

@implementation PKRequest

@synthesize uri = uri_;
@synthesize method = method_;
@synthesize parameters = parameters_;
@synthesize body = body_;
@synthesize objectMapping = objectMapping_;
@synthesize objectDataPathComponents = objectDataPathComponents_;
@synthesize userInfo = userInfo_;
@synthesize scopePredicate = scopePredicate_;
@synthesize offset = offset_;
@synthesize mappingBlock = mappingBlock_;

- (id)initWithURI:(NSString *)uri method:(PKRequestMethod)method {
  self = [super init];
  if (self) {
    uri_ = [uri copy];
    method_ = [method copy];
    parameters_ = [[NSMutableDictionary alloc] init];
    body_ = nil;
    objectMapping_ = nil;
    objectDataPathComponents_ = nil;
    userInfo_ = nil;
    scopePredicate_ = nil;
    offset_ = 0;
    mappingBlock_ = nil;
  }
  
  return self;
}

- (id)initWithURI:(NSString *)uri method:(PKRequestMethod)method objectMapping:(PKObjectMapping *)objectMapping {
  self = [self initWithURI:uri method:method];
  if (self) {
    objectMapping_ = objectMapping;
  }
  
  return self;
}


+ (PKRequest *)requestWithURI:(NSString *)uri method:(PKRequestMethod)method {
  return [[self alloc] initWithURI:uri method:method];
}

+ (PKRequest *)requestWithURI:(NSString *)uri method:(PKRequestMethod)method objectMapping:(PKObjectMapping *)objectMapping {
  return [[self alloc] initWithURI:uri method:method objectMapping:objectMapping];
}

+ (PKRequest *)getRequestWithURI:(NSString *)uri {
  return [self requestWithURI:uri method:PKRequestMethodGET];
}

+ (PKRequest *)putRequestWithURI:(NSString *)uri {
  return [self requestWithURI:uri method:PKRequestMethodPUT];
}

+ (PKRequest *)postRequestWithURI:(NSString *)uri {
  return [self requestWithURI:uri method:PKRequestMethodPOST];
}

+ (PKRequest *)deleteRequestWithURI:(NSString *)uri {
  return [self requestWithURI:uri method:PKRequestMethodDELETE];
}

- (PKRequestOperation *)startWithCompletionBlock:(PKRequestCompletionBlock)completionBlock {
  return [[PKRequestManager sharedManager] performRequest:self completion:completionBlock];
}

@end
