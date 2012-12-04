//
//  PKRequestOperation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/12/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKRequestOperation.h"
#import "PKRequestResult.h"
#import "NSDictionary+PKAdditions.h"


static NSTimeInterval const kTimeout = 30;

// Exceptions
NSString * const PKNoObjectMapperSetException = @"PKNoObjectMapperSetException";

@interface PKRequestOperation ()

- (id)performMappingOfData:(id)data;

@end

@implementation PKRequestOperation

@synthesize objectMapper = objectMapper_;
@synthesize objectDataPathComponents = objectDataPathComponents_;
@synthesize requestCompletionBlock = requestCompletionBlock_;
@synthesize allowsConcurrent = allowsConcurrent_;
@synthesize requiresAuthenticated = requiresAuthenticated_;

- (id)initWithURLString:(NSString *)urlString method:(NSString *)method {
  NSURL *requestURL = [NSURL URLWithString:urlString];
  self = [super initWithURL:requestURL];
  if (self) {
    self.requestMethod = method;
    self.timeOutSeconds = kTimeout;
    self.showAccurateProgress = NO;
    objectMapper_ = nil;
    requestCompletionBlock_ = nil;
    allowsConcurrent_ = YES;
    requiresAuthenticated_ = YES;
  }
  return self;
}

+ (PKRequestOperation *)operationWithURLString:(NSString *)urlString 
                                        method:(NSString *)method 
                                          body:(id)body {
  PKRequestOperation *operation = [[self alloc] initWithURLString:urlString method:method];
  operation.validatesSecureCertificate = YES;
  operation.shouldAttemptPersistentConnection = NO;
  
  // Body
  if (body != nil) {
    [operation addRequestHeader: @"Content-Type" value: @"application/json"];
    
    NSError *error = nil;
    NSData *bodyData = [NSJSONSerialization dataWithJSONObject:body options:0 error:&error];
    if (error != nil) {
      PKLogError(@"Failed to serialize request body data: %@, %@", error, [error userInfo]);
    }
    
    [operation appendPostData:bodyData];
  }
  
  return operation;
}

- (void)requestFinished {
  if ([self isCancelled]) {
    [super requestFinished];
    return;
  }
  
  id resultData = nil;
  id parsedData = nil;
  id objectData = nil;
  NSError *requestError = nil;
  
  // Parse
  NSData *responseData = self.responseData;
  if ([responseData length] > 0) {
    NSError *parseError = nil;
    parsedData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
    
    if (parseError) {
      PKLogError(@"Failed to parse response data: %@, %@", parseError, [parseError userInfo]);
      requestError = [NSError pk_responseParseError];
    }
  }
  
  PKLogDebug(@"Request finished with status code: %d", self.responseStatusCode);
  
  // Handle
  switch (self.responseStatusCode) {
    case 200:
    case 201: {
      if (parsedData) {
        objectData = parsedData;
        if (self.objectDataPathComponents != nil) {
          objectData = [parsedData pk_objectForPathComponents:self.objectDataPathComponents];
        }
        
        // Should map response?
        if (self.objectMapper != nil) {
          resultData = [self performMappingOfData:objectData];
        }
      }
      break;
    }
    case 204:
      // Sucess without data
      break;
    default: {
      // Failed
      PKLogDebug(@"Request failed with body: %@", self.responseString);
      requestError = [NSError pk_serverErrorWithStatusCode:self.responseStatusCode parsedData:parsedData];
      break;
    }
  }
  
  PKRequestResult *result = [PKRequestResult resultWithResponseStatusCode:self.responseStatusCode 
                                                             responseData:self.responseData 
                                                               parsedData:parsedData
                                                               objectData:objectData
                                                               resultData:resultData];
  
  // Completion handler on main thread
  if (self.requestCompletionBlock) {
    dispatch_async(dispatch_get_main_queue(), ^{
      self.requestCompletionBlock(requestError, result);
    });
  }
  
  [super requestFinished];
}

// Request failed
- (void)failWithError:(NSError *)theError {
  
  if (![self isCancelled] && 
      !([[theError domain] isEqualToString:NetworkRequestErrorDomain] && [theError code] == ASIRequestCancelledErrorType)) { // Request cancelled
    
    PKLogError(@"Request failed with code %d, %@, ", [self responseStatusCode], [self responseString]);
    PKLogError(@"Request failed with error: %@, %@", [theError localizedDescription], [theError userInfo]);
    PKLogError(@"Request debug info:\n  Method: %@\n  URL: %@\n  Headers: %@", [self requestMethod], [[self url] absoluteString], [self requestHeaders]);

    // Completion handler on main thread
    if (self.requestCompletionBlock) {
      dispatch_async(dispatch_get_main_queue(), ^{
        self.requestCompletionBlock(theError, nil);
      });
    }
  }
  
  [super failWithError:theError];
}

- (id)performMappingOfData:(id)data {
  
  if (self.objectMapper == nil) {
    [NSException raise:PKNoObjectMapperSetException format:@"No object mapper set, unable to perform mapping of response data."];
  }
  
  id result = nil;
  @autoreleasepool {
    result = [self.objectMapper performMappingWithData:data];
  }
  
  return result;
}

@end
