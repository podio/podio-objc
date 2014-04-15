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
#import "PKTSessionManager.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";

@interface PKTClient ()

@property (nonatomic, copy, readwrite) NSString *apiKey;
@property (nonatomic, copy, readwrite) NSString *apiSecret;

@end

@implementation PKTClient

+ (instancetype)sharedClient {
  static PKTClient *sharedClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedClient = [self new];
  });
  
  return sharedClient;
}

- (instancetype)init {
  return [self initWithAPIKey:nil secret:nil];
}

- (instancetype)initWithAPIKey:(NSString *)key secret:(NSString *)secret {
  @synchronized(self) {
    NSURL *baseURL = [[NSURL alloc] initWithString:kDefaultBaseURLString];
    self = [super initWithBaseURL:baseURL];
    if (!self) return nil;
    
    _apiKey = [key copy];
    _apiSecret = [secret copy];

    self.requestSerializer = [PKTRequestSerializer serializer];
    
    return self;
  }
}

#pragma mark - Public

- (void)setupWithAPIKey:(NSString *)key secret:(NSString *)secret {
  self.apiKey = key;
  self.apiSecret = secret;
}

- (void)setValue:(NSString *)value forHTTPHeader:(NSString *)header {
  [self.requestSerializer setValue:value forHTTPHeaderField:header];
}

- (void)setAuthorizationHeaderWithOAuth2AccessToken:(NSString *)accessToken {
  NSParameterAssert(accessToken);
  [(PKTRequestSerializer *)self.requestSerializer setAuthorizationHeaderFieldWithOAuth2AccessToken:accessToken];
}

- (void)setAuthorizationHeaderWithAPICredentials {
  [self.requestSerializer setAuthorizationHeaderFieldWithUsername:self.apiKey password:self.apiSecret];
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
