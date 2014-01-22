//
//  PKTRequestSerializer.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequestSerializer.h"
#import "NSString+PKTRandom.h"

static NSString * const kHeaderRequestId = @"X-Podio-Request-Id";
static NSUInteger const kRequestIdLength = 8;

@implementation PKTRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
  NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];

  [request setValue:[self generatedRequestId] forHTTPHeaderField:kHeaderRequestId];

  return request;
}

#pragma mark - Private

- (NSString *)generatedRequestId {
  return [NSString pkt_randomHexStringOfLength:kRequestIdLength];
}

@end
