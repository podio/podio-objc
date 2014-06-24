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

@interface PKTRequestSerializer ()

@property (nonatomic, assign) PKTRequestContentType requestContentType;

@end

@implementation PKTRequestSerializer

#pragma mark - AFURLRequestSerialization

- (NSURLRequest *)requestBySerializingRequest:(NSURLRequest *)request withParameters:(id)parameters error:(NSError *__autoreleasing *)error {
  NSParameterAssert(request);
  
  if ([self.HTTPMethodsEncodingParametersInURI containsObject:[[request HTTPMethod] uppercaseString]] ||
      self.requestContentType == PKTRequestContentTypeFormURLEncoded) {
    return [super requestBySerializingRequest:request withParameters:parameters error:error];
  }
  
  // Format as JSON
  NSMutableURLRequest *mutableRequest = [request mutableCopy];
  
  [self.HTTPRequestHeaders enumerateKeysAndObjectsUsingBlock:^(id field, id value, BOOL * __unused stop) {
    if (![request valueForHTTPHeaderField:field]) {
      [mutableRequest setValue:value forHTTPHeaderField:field];
    }
  }];
  
  if (!parameters) {
    return mutableRequest;
  }
  
  NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
  
  [mutableRequest setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
  [mutableRequest setHTTPBody:[NSJSONSerialization dataWithJSONObject:parameters options:0 error:error]];
  
  return mutableRequest;
}

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

- (NSMutableURLRequest *)multipartFormRequestWithMethod:(NSString *)method URLString:(NSString *)URLString parameters:(NSDictionary *)parameters fileData:(PKTRequestFileData *)fileData error:(NSError *__autoreleasing *)error {
  NSMutableURLRequest *request = [super multipartFormRequestWithMethod:method URLString:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
    if (fileData.data) {
      [formData appendPartWithFileData:fileData.data
                                  name:fileData.name
                              fileName:fileData.fileName
                              mimeType:fileData.mimeType];
    } else if (fileData.fileURL) {
      [formData appendPartWithFileURL:fileData.fileURL
                                 name:fileData.name
                             fileName:fileData.fileName
                             mimeType:fileData.mimeType
                                error:nil];
    }
  } error:error];
  
  [request setValue:[self generatedRequestId] forHTTPHeaderField:kHeaderRequestId];
  
  return request;
}

- (NSMutableURLRequest *)URLRequestForRequest:(PKTRequest *)request relativeToURL:(NSURL *)baseURL {
  @synchronized(self) {
    NSParameterAssert(request);
    NSParameterAssert(baseURL);
    
    NSURL *url = nil;
    if (request.URL) {
      url = request.URL;
    } else {
      NSParameterAssert(request.path);
      url = [NSURL URLWithString:request.path relativeToURL:baseURL];
    }
    
    NSString *urlString = [url absoluteString];
    NSString *method = [[self class] HTTPMethodForMethod:request.method];
    
    NSMutableURLRequest *urlRequest = nil;
    
    if (request.contentType == PKTRequestContentTypeMultipart) {
      urlRequest = [self multipartFormRequestWithMethod:method
                                              URLString:urlString
                                             parameters:request.parameters
                                               fileData:request.fileData
                                                  error:nil];
    } else {
      // Use content type of request
      PKTRequestContentType contentType = self.requestContentType;
      self.requestContentType = request.contentType;

      urlRequest = [self requestWithMethod:method URLString:urlString parameters:request.parameters error:nil];

      // Reset content type
      self.requestContentType = contentType;
    }

    if (request.URLRequestConfigurationBlock) {
      urlRequest = [request.URLRequestConfigurationBlock(urlRequest) mutableCopy];
    }
    
    return urlRequest;
  }
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
