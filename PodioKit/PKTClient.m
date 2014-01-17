//
//  PKTClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTClient.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";

@interface PKTClient ()

@property (nonatomic, copy, readwrite) NSString *apiKey;
@property (nonatomic, copy, readwrite) NSString *apiSecret;

@end

@implementation PKTClient

- (instancetype)initWithAPIKey:(NSString *)key secret:(NSString *)secret {
  NSParameterAssert(key);
  NSParameterAssert(secret);
  
  NSURL *baseURL = [[NSURL alloc] initWithString:kDefaultBaseURLString];
  self = [super initWithBaseURL:baseURL];
  if (!self) return nil;
  
  _apiKey = [key copy];
  _apiSecret = [secret copy];
  
  return self;
}

- (void)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  
}


@end
