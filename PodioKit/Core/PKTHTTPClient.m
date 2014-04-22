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

- (instancetype)init {
  NSURL *baseURL = [[NSURL alloc] initWithString:kDefaultBaseURLString];
  self = [super initWithBaseURL:baseURL];
  if (!self) return nil;

  self.requestSerializer = [PKTRequestSerializer serializer];
  
  return self;
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

- (AFHTTPRequestOperation *)operationWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLRequest *urlRequest = [(PKTRequestSerializer *)self.requestSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  
  return [self HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSUInteger statusCode = operation.response.statusCode;
    PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:statusCode body:responseObject];
    
    if (completion) completion(response, nil);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSUInteger statusCode = operation.response.statusCode;
    PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:statusCode body:operation.responseObject];
    
    if (completion) completion(response, error);
  }];
}

@end
