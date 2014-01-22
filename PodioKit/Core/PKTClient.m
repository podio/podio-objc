//
//  PKTClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTClient.h"
#import "PKTRequest.h"
#import "PKTResponse.h"
#import "PKTRequestSerializer.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";

static NSString * const kHTTPMethodGET = @"GET";
static NSString * const kHTTPMethodPOST = @"POST";
static NSString * const kHTTPMethodPUT = @"PUT";
static NSString * const kHTTPMethodDELETE = @"DELETE";

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

  self.requestSerializer = [PKTRequestSerializer serializer];
  
  return self;
}

#pragma mark - Public

- (void)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLSessionTask *task = [self taskWithRequest:request completion:completion];
  [task resume];
}

#pragma mark - Private

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

- (NSURLRequest *)URLRequestForRequest:(PKTRequest *)request {
  NSString *urlString = [[NSURL URLWithString:request.path relativeToURL:self.baseURL] absoluteString];
  NSString *method = [[self class] HTTPMethodForMethod:request.method];
  
  NSMutableURLRequest *urlRequest = [self.requestSerializer
                                  requestWithMethod:method
                                  URLString:urlString
                                  parameters:request.parameters
                                  error:nil];
  
  return [urlRequest copy];
}

- (NSURLSessionTask *)taskWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLRequest *urlRequest = [self URLRequestForRequest:request];
  
  return [self dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *urlResponse, id responseObject, NSError *error) {
    PKTResponse *response = nil;
    if (!error) {
      response = [PKTResponse new];
    }
    
    if (completion) completion(response, error);
  }];
}

@end
