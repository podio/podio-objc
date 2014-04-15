//
//  PKTClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTHTTPClient.h"
#import "PKTRequest.h"
#import "PKTResponse.h"
#import "PKTRequestSerializer.h"
#import "PKTClient.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";

@interface PKTHTTPClient ()

@end

@implementation PKTHTTPClient

+ (instancetype)sharedClient {
  static PKTHTTPClient *sharedClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedClient = [self new];
  });
  
  return sharedClient;
}

- (instancetype)init {
  @synchronized(self) {
    NSURL *baseURL = [[NSURL alloc] initWithString:kDefaultBaseURLString];
    self = [super initWithBaseURL:baseURL];
    if (!self) return nil;

    self.requestSerializer = [PKTRequestSerializer serializer];
    
    return self;
  }
}

#pragma mark - Public

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header {
  [self.requestSerializer setValue:value forHTTPHeaderField:header];
}

- (void)setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken {
  NSParameterAssert(accessToken);
  [(PKTRequestSerializer *)self.requestSerializer setAuthorizationHeaderFieldWithOAuth2AccessToken:accessToken];
}

- (void)setAuthorizationHeaderWithAPIKey:(NSString *)key secret:(NSString *)secret {
  [self.requestSerializer setAuthorizationHeaderFieldWithUsername:key password:secret];
}

- (NSURLSessionTask *)performRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLSessionTask *task = [self taskWithRequest:request completion:completion];
  [task resume];

  return task;
}

#pragma mark - Private

- (NSURLSessionTask *)taskWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLRequest *urlRequest = [(PKTRequestSerializer *)self.requestSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  
  return [self dataTaskWithRequest:urlRequest completionHandler:^(NSURLResponse *urlResponse, id responseObject, NSError *error) {
    PKTResponse *response = nil;
    if (!error) {
      // TODO: parse response
      response = [PKTResponse new];
    }
    
    if (completion) completion(response, error);
  }];
}

@end
