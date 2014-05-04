//
//  PKTResponse.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTResponse.h"

@implementation PKTResponse

- (instancetype)initWithStatusCode:(NSInteger)statusCode body:(id)body {
  self = [super init];
  if (!self) return nil;
  
  _statusCode = statusCode;
  _body = body;
  
  return self;
}

@end
