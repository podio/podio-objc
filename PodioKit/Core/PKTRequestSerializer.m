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

static NSString * const kHeaderAuthorization = @"Authorization";
static NSString * const kAuthorizationTokenFormat = @"OAuth2 %@";

@implementation PKTRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
  NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];

  [request setValue:[self generatedRequestId] forHTTPHeaderField:kHeaderRequestId];

  return request;
}

- (void)setAuthorizationHeaderFieldWithToken:(NSString *)token {
  NSParameterAssert(token);

  [self setValue:[NSString stringWithFormat:kAuthorizationTokenFormat, token] forHTTPHeaderField:kHeaderAuthorization];
}

#pragma mark - Private

- (NSString *)generatedRequestId {
  return [NSString pkt_randomHexStringOfLength:kRequestIdLength];
}

@end
