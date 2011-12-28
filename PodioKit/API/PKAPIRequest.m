//
//  PKAPIRequest.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAPIRequest.h"


PKAPIRequestMethod const PKAPIRequestMethodGET = @"GET";
PKAPIRequestMethod const PKAPIRequestMethodPOST = @"POST";
PKAPIRequestMethod const PKAPIRequestMethodPUT = @"PUT";
PKAPIRequestMethod const PKAPIRequestMethodDELETE = @"DELETE";

@implementation PKAPIRequest

@synthesize path = path_;
@synthesize authenticated = authenticated_;
@synthesize getParameters = getParameters_;
@synthesize postParameters = postParameters_;

- (id)initWithPath:(NSString *)path method:(PKAPIRequestMethod)method {
  self = [super init];
  if (self) {
    self.path = path;
    self.authenticated = YES;
    getParameters_ = nil;
    postParameters_ = nil;
  }
  return self;
}

- (void)dealloc {
  [path_ release];
  [method_ release];
  [getParameters_ release];
  [postParameters_ release];
  [super dealloc];
}

+ (id)requestWithPath:(NSString *)path method:(PKAPIRequestMethod)method {
  return [[[self alloc] initWithPath:path method:method] autorelease];
}

@end
