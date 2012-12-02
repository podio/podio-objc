//
//  PKHTTPRequestOperation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/30/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKHTTPRequestOperation.h"
#import "PKObjectMapper.h"
#import "NSDictionary+PKAdditions.h"

NSString * const PKAPIClientRequestFinished = @"PKAPIClientRequestFinished";
NSString * const PKAPIClientRequestFailed = @"PKAPIClientRequestFailed";

NSString * const PKAPIClientRequestKey = @"Request";

@interface PKHTTPRequestOperation ()

@property (nonatomic, strong) NSURLRequest *request;

@end

@implementation PKHTTPRequestOperation

+ (PKHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request completion:(PKRequestCompletionBlock)completion {
  PKHTTPRequestOperation *operation = [[self alloc] initWithRequest:request];
  operation.requestCompletionBlock = completion;
  
  return operation;
}

+ (BOOL)canProcessRequest:(NSURLRequest *)urlRequest {
  return YES;
}

#pragma mark - Properties

- (void)setRequestCompletionBlock:(PKRequestCompletionBlock)requestCompletionBlock {
  // completionBlock is manually nilled out in AFURLConnectionOperation to break the retain cycle.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-retain-cycles"
  self.completionBlock = ^{
    if ([self isCancelled]) {
      // Completion handler on main thread
      if (requestCompletionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
          requestCompletionBlock([NSError pk_requestCancelledError], nil);
        });
      }
      
      return;
    }
    
    if (!self.error) {
      id resultData = nil;
      id parsedData = nil;
      id objectData = nil;
      NSError *requestError = nil;
      
      if ([self.responseData length] > 0) {
        NSError *parseError = nil;
        parsedData = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:&parseError];
        
        if (parseError) {
          PKLogError(@"Failed to parse response data: %@, %@", parseError, [parseError userInfo]);
          requestError = [NSError pk_responseParseError];
        }
      }
      
      PKLogDebug(@"Request finished with status code: %d", self.response.statusCode);
      
      if (self.response.statusCode >= 200 && self.response.statusCode <= 206) {
        if (self.response.statusCode != 204 && parsedData) {
          objectData = parsedData;
          if (self.objectDataPathComponents != nil) {
            objectData = [parsedData pk_objectForPathComponents:self.objectDataPathComponents];
          }
          
          // Should map response?
          if (self.objectMapper != nil) {
            @autoreleasepool {
              resultData = [self.objectMapper performMappingWithData:objectData];
            }
          }
        }
      } else {
        // Failed on server side
        PKLogDebug(@"Request failed with body: %@", self.responseString);
        requestError = [NSError pk_serverErrorWithStatusCode:self.response.statusCode parsedData:parsedData];
      }
      
      PKRequestResult *result = [PKRequestResult resultWithResponseStatusCode:self.response.statusCode
                                                                 responseData:self.responseData
                                                                   parsedData:parsedData
                                                                   objectData:objectData
                                                                   resultData:resultData];
      
      // Completion handler on main thread
      if (requestCompletionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
          requestCompletionBlock(requestError, result);
        });
      }
      
      NSDictionary *userInfo = @{PKAPIClientRequestKey: self};
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientRequestFinished object:self userInfo:userInfo];
    } else {
      if (requestCompletionBlock) {
        dispatch_async(dispatch_get_main_queue(), ^{
          requestCompletionBlock(self.error, nil);
        });
      }
      
      NSDictionary *userInfo = @{PKAPIClientRequestKey: self};
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientRequestFailed object:self userInfo:userInfo];
    }
  };
#pragma clang diagnostic pop
}

#pragma mark - Impl

- (void)setValue:(NSString *)value forHeader:(NSString *)header {
  NSMutableURLRequest *mutableRequest = [self.request mutableCopy];
  [mutableRequest setValue:value forHTTPHeaderField:header];
  self.request = mutableRequest;
}

@end
