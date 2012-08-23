//
//  PKAPIRequest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAPIRequest.h"


PKAPIRequestMethod const PKAPIRequestMethodGET = @"GET";
PKAPIRequestMethod const PKAPIRequestMethodPOST = @"POST";
PKAPIRequestMethod const PKAPIRequestMethodPUT = @"PUT";
PKAPIRequestMethod const PKAPIRequestMethodDELETE = @"DELETE";

@interface PKAPIRequest ()

@property (nonatomic, copy) PKAPIRequestMethod method;

@end

@implementation PKAPIRequest

@synthesize path = path_;
@synthesize authenticated = authenticated_;
@synthesize getParameters = getParameters_;
@synthesize postParameters = postParameters_;
@synthesize method = method_;

- (id)initWithPath:(NSString *)path method:(PKAPIRequestMethod)method {
  self = [super init];
  if (self) {
    path_ = path;
    authenticated_ = YES;
    getParameters_ = nil;
    postParameters_ = nil;
  }
  return self;
}


+ (id)requestWithPath:(NSString *)path method:(PKAPIRequestMethod)method {
  return [[self alloc] initWithPath:path method:method];
}

@end
