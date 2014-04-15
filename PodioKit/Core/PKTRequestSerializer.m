//
//  PKTRequestSerializer.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequestSerializer.h"
#import "NSString+PKTRandom.h"
#import "PKTRequest.h"

static NSString * const kHTTPMethodGET = @"GET";
static NSString * const kHTTPMethodPOST = @"POST";
static NSString * const kHTTPMethodPUT = @"PUT";
static NSString * const kHTTPMethodDELETE = @"DELETE";

static NSString * const kHeaderRequestId = @"X-Podio-Request-Id";
static NSUInteger const kRequestIdLength = 8;

static NSString * const kHeaderAuthorization = @"Authorization";
static NSString * const kAuthorizationOAuth2AccessTokenFormat = @"OAuth2 %@";

@implementation PKTRequestSerializer

#pragma mark - HTTP headers

- (void)setAuthorizationHeaderFieldWithOAuth2AccessToken:(NSString *)accessToken {
  NSParameterAssert(accessToken);

  [self setValue:[NSString stringWithFormat:kAuthorizationOAuth2AccessTokenFormat, accessToken] forHTTPHeaderField:kHeaderAuthorization];
}

#pragma mark - URL request

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters error:(NSError *__autoreleasing *)error {
  NSMutableURLRequest *request = [super requestWithMethod:method URLString:URLString parameters:parameters error:error];

  [request setValue:[self generatedRequestId] forHTTPHeaderField:kHeaderRequestId];

  return request;
}

- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request relativeToURL:(NSURL *)baseURL {
  NSParameterAssert(request);
  NSParameterAssert(baseURL);

  NSString *urlString = [[NSURL URLWithString:request.path relativeToURL:baseURL] absoluteString];
  NSString *method = [[self class] HTTPMethodForMethod:request.method];

  return [self requestWithMethod:method URLString:urlString parameters:request.parameters error:nil];
}

#pragma mark - Private

- (NSString *)generatedRequestId {
  return [NSString pkt_randomHexStringOfLength:kRequestIdLength];
}

+ (NSString *)HTTPMethodForMethod:(PKTRequestMethod)method {
  NSString *string = nil;

  switch (method) {
    case PKTRequestMethodGET:
      string = kHTTPMethodGET;
      break;
    case PKTRequestMethodPOST:
      string = kHTTPMethodPOST;
      break;
    case PKTRequestMethodPUT:
      string = kHTTPMethodPUT;
      break;
    case PKTRequestMethodDELETE:
      string = kHTTPMethodDELETE;
      break;
    default:
      break;
  }

  return string;
}

@end
