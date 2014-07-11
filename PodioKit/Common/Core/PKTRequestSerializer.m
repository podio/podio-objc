//
//  PKTRequestSerializer.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequestSerializer.h"
#import "PKTRequest.h"
#import "PKTMultipartFormData.h"
#import "NSString+PKTRandom.h"
#import "NSString+PKTBase64.h"
#import "NSURL+PKTAdditions.h"
#import "NSDictionary+PKTQueryParameters.h"

static NSString * const kHTTPMethodGET = @"GET";
static NSString * const kHTTPMethodPOST = @"POST";
static NSString * const kHTTPMethodPUT = @"PUT";
static NSString * const kHTTPMethodDELETE = @"DELETE";
static NSString * const kHTTPMethodHEAD = @"HEAD";

static NSString * const kHeaderRequestId = @"X-Podio-Request-Id";
static NSUInteger const kRequestIdLength = 8;

static NSString * const kHeaderAuthorization = @"Authorization";
static NSString * const kAuthorizationOAuth2AccessTokenFormat = @"OAuth2 %@";

static NSString * const kHeaderContentType = @"Content-Type";
static NSString * const kHeaderContentLength = @"Content-Length";

static NSString * const kBoundaryPrefix = @"----------------------";
static NSUInteger const kBoundaryLength = 20;

@interface PKTRequestSerializer ()

@property (nonatomic, assign) PKTRequestContentType requestContentType;
@property (nonatomic, copy, readonly) NSString *boundary;
@property (nonatomic, strong, readonly) NSMutableDictionary *mutAdditionalHTTPHeaders;

@end

@implementation PKTRequestSerializer

@synthesize boundary = _boundary;
@synthesize mutAdditionalHTTPHeaders = _mutAdditionalHTTPHeaders;

- (NSString *)boundary {
  if (!_boundary) {
    _boundary = [NSString stringWithFormat:@"%@%@", kBoundaryPrefix, [NSString pkt_randomHexStringOfLength:kBoundaryLength]];
  }
  
  return _boundary;
}

- (NSMutableDictionary *)mutAdditionalHTTPHeaders {
  if (!_mutAdditionalHTTPHeaders) {
    _mutAdditionalHTTPHeaders = [NSMutableDictionary new];
  }
  
  return _mutAdditionalHTTPHeaders;
}

- (NSDictionary *)additionalHTTPHeaders {
  return [self.mutAdditionalHTTPHeaders copy];
}

#pragma mark Public

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header {
  NSParameterAssert(header);
  
  if (value) {
    self.mutAdditionalHTTPHeaders[header] = value;
  } else {
    [self.mutAdditionalHTTPHeaders removeObjectForKey:header];
  }
}

- (void)setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken {
  NSParameterAssert(accessToken);
  [self setValue:[NSString stringWithFormat:kAuthorizationOAuth2AccessTokenFormat, accessToken] forHTTPHeader:kHeaderAuthorization];
}

- (void)setAuthorizationHeaderWithAPIKey:(NSString *)key secret:(NSString *)secret {
  NSParameterAssert(key);
  NSParameterAssert(secret);
  
  NSString *credentials = [NSString stringWithFormat:@"%@:%@", key, secret];
  [self setValue:[NSString stringWithFormat:@"Basic %@", [credentials pkt_base64String]] forHTTPHeader:kHeaderAuthorization];
}

#pragma mark - URL request

- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request relativeToURL:(NSURL *)baseURL {
  return [self URLRequestForRequest:request multipartData:nil relativeToURL:baseURL];
}

- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request multipartData:(PKTMultipartFormData *)multipartData relativeToURL:(NSURL *)baseURL {
  NSParameterAssert(request);
  NSParameterAssert(baseURL);
  
  NSURL *url = nil;
  if (request.URL) {
    url = request.URL;
  } else {
    NSParameterAssert(request.path);
    url = [NSURL URLWithString:request.path relativeToURL:baseURL];
  }
  
  if (request.parameters && [[self class] supportsQueryParametersForRequestMethod:request.method]) {
    url = [url pkt_URLByAppendingQueryParameters:request.parameters];
  }
  
  NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
  urlRequest.HTTPMethod = [[self class] HTTPMethodForMethod:request.method];
  [urlRequest setValue:[[self class] generatedRequestId] forHTTPHeaderField:kHeaderRequestId];
  [urlRequest setValue:[self contentTypeForRequest:request] forHTTPHeaderField:kHeaderContentType];
  
  if (multipartData) {
    NSString *contentLength = [NSString stringWithFormat:@"%lu", (unsigned long)multipartData.finalizedData.length];
    [urlRequest setValue:contentLength forHTTPHeaderField:kHeaderContentLength];
  }
  
  [self.additionalHTTPHeaders enumerateKeysAndObjectsUsingBlock:^(NSString *header, NSString *value, BOOL *stop) {
    [urlRequest setValue:value forHTTPHeaderField:header];
  }];
  
  urlRequest.HTTPBody = [[self class] bodyDataForRequest:request];
  
  if (request.URLRequestConfigurationBlock) {
    urlRequest = [request.URLRequestConfigurationBlock(urlRequest) mutableCopy];
  }
  
  return urlRequest;
}

- (PKTMultipartFormData *)multipartFormDataFromRequest:(PKTRequest *)request {
  PKTMultipartFormData *multiPartData = [PKTMultipartFormData multipartFormDataWithBoundary:self.boundary encoding:NSUTF8StringEncoding];
  
  if (request.fileData.data) {
    [multiPartData appendFileData:request.fileData.data fileName:request.fileData.fileName mimeType:nil name:request.fileData.name];
  }
  
  if ([request.parameters count] > 0) {
    [multiPartData appendFormDataParameters:request.parameters];
  }
  
  [multiPartData finalizeData];
  
  return multiPartData;
}

#pragma mark - Private

+ (NSString *)generatedRequestId {
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
    case PKTRequestMethodHEAD:
      string = kHTTPMethodHEAD;
      break;
    default:
      break;
  }

  return string;
}

+ (NSData *)bodyDataForRequest:(PKTRequest *)request {
  NSData *data = nil;
  
  if (request.parameters && ![self supportsQueryParametersForRequestMethod:request.method]) {
    if (request.contentType == PKTRequestContentTypeJSON) {
      data = [NSJSONSerialization dataWithJSONObject:request.parameters options:0 error:nil];
    } else if (request.contentType == PKTRequestContentTypeFormURLEncoded) {
      data = [[request.parameters pkt_escapedQueryString] dataUsingEncoding:NSUTF8StringEncoding];
    }
  }
  
  return data;
}

+ (BOOL)supportsQueryParametersForRequestMethod:(PKTRequestMethod)method {
  return method == PKTRequestMethodGET || method == PKTRequestMethodDELETE || method == PKTRequestMethodHEAD;
}

- (NSString *)contentTypeForRequest:(PKTRequest *)request {
  NSString *contentType = nil;
  
  static NSString *charset = nil;
  static dispatch_once_t charsetToken;
  dispatch_once(&charsetToken, ^{
    charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
  });
  
  switch (request.contentType) {
    case PKTRequestContentTypeMultipart:
      contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", self.boundary];
      break;
    case PKTRequestContentTypeFormURLEncoded:
      contentType = [NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset];
      break;
    case PKTRequestContentTypeJSON:
      contentType = [NSString stringWithFormat:@"application/json; charset=%@", charset];
    default:
      
      break;
  }
  
  return contentType;
}

@end
