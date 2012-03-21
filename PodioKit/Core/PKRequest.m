//
//  PKRequest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKRequest.h"
#import "PKObjectMapping.h"
#import "PKRequestOperation.h"
#import "PKRequestManager.h"


@implementation PKRequest

@synthesize uri = uri_;
@synthesize method = method_;
@synthesize parameters = parameters_;
@synthesize body = body_;
@synthesize objectMapping = objectMapping_;
@synthesize userInfo = userInfo_;
@synthesize scopePredicate = scopePredicate_;
@synthesize offset = offset_;
@synthesize mappingBlock = mappingBlock_;
@synthesize allowsConcurrent = allowsConcurrent_;

- (id)initWithURI:(NSString *)uri method:(PKAPIRequestMethod)method {
  self = [super init];
  if (self) {
    uri_ = [uri copy];
    method_ = [method copy];
    parameters_ = [[NSMutableDictionary alloc] init];
    body_ = nil;
    objectMapping_ = nil;
    userInfo_ = nil;
    scopePredicate_ = nil;
    offset_ = 0;
    mappingBlock_ = nil;
    allowsConcurrent_ = YES;
  }
  
  return self;
}

- (id)initWithURI:(NSString *)uri method:(PKAPIRequestMethod)method objectMapping:(PKObjectMapping *)objectMapping {
  self = [self initWithURI:uri method:method];
  if (self) {
    objectMapping_ = objectMapping;
  }
  
  return self;
}


+ (PKRequest *)requestWithURI:(NSString *)uri method:(PKAPIRequestMethod)method {
  return [[self alloc] initWithURI:uri method:method];
}

+ (PKRequest *)requestWithURI:(NSString *)uri method:(PKAPIRequestMethod)method objectMapping:(PKObjectMapping *)objectMapping {
  return [[self alloc] initWithURI:uri method:method objectMapping:objectMapping];
}

- (PKRequestOperation *)startWithCompletionBlock:(PKRequestCompletionBlock)completionBlock {
  return [[PKRequestManager sharedManager] performRequest:self completion:completionBlock];
}

@end
