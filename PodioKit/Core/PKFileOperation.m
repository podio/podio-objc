//
//  PKFileRequestOperation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKFileOperation.h"

static NSTimeInterval const kTimeout = 30;

@implementation PKFileOperation

@synthesize requestCompletionBlock = requestCompletionBlock_;

- (id)initWithURLString:(NSString *)urlString {
  NSURL *requestURL = [NSURL URLWithString:urlString];
  self = [super initWithURL:requestURL];
  if (self) {
    self.requestMethod = PKRequestMethodPOST;
    self.timeOutSeconds = kTimeout;
  }
  return self;
}

+ (PKFileOperation *)uploadOperationWithURLString:(NSString *)urlString filePath:(NSString *)filePath fileName:(NSString *)fileName {
  PKFileOperation *operation = [[self alloc] initWithURLString:urlString];
  operation.shouldAttemptPersistentConnection = NO;
  
  [operation setFile:filePath withFileName:fileName andContentType:nil forKey:@"file"];
	operation.numberOfTimesToRetryOnTimeout = 2;
  
  return operation;
}

+ (PKFileOperation *)imageUploadOperationWithURLString:(NSString *)urlString image:(UIImage *)image fileName:(NSString *)fileName {
  PKFileOperation *operation = [[self alloc] initWithURLString:urlString];
  operation.shouldAttemptPersistentConnection = NO;
  
  NSData * imageData = UIImageJPEGRepresentation(image, 0.8);
  [operation setData:imageData withFileName:fileName andContentType:@"image/jpeg" forKey:@"file"];
  [operation setPostValue:fileName forKey:@"name"];
	operation.numberOfTimesToRetryOnTimeout = 2;
  
  return operation;
}

// Request succeeded
- (void)requestFinished {
  
  if ([self isCancelled]) {
    // Cancelled
    [super requestFinished];
    return;
  }
  
  id resultData = nil;
  id parsedData = nil;
  NSError *requestError = nil;
  
  NSData *responseData = self.responseData;
  if ([responseData length] > 0) {
    NSError *parseError = nil;
    parsedData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&parseError];
    
    if (parseError) {
      PKLogError(@"Failed to parse response data: %@, %@", parseError, [parseError userInfo]);
    }
  }
  
  PKLogDebug(@"Request finished with status code %d", self.responseStatusCode);
  
  switch (self.responseStatusCode) {
    case 200:
    case 201:
    case 204:
      break;
    default:
      // Failed
      PKLogDebug(@"Request failed with status code %d: %@", self.responseStatusCode, self.responseString);
      requestError = [NSError pk_serverErrorWithStatusCode:self.responseStatusCode parsedData:parsedData];
      break;
  }
  
  PKRequestResult *result = [PKRequestResult resultWithResponseStatusCode:self.responseStatusCode 
                                                             responseData:self.responseData 
                                                               parsedData:parsedData 
                                                               objectData:nil
                                                               resultData:resultData];
  
  // Completion handler on main thread
  if (self.requestCompletionBlock != nil) {
    
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
    if (self.requestCompletionBlock != nil) {
      
      dispatch_async(dispatch_get_main_queue(), ^{
        self.requestCompletionBlock(error, nil);
      });
    }
  }
  
  [super failWithError:theError];
}

@end
