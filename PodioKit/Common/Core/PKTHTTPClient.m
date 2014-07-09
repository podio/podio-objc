//
//  PKTClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTHTTPClient.h"
#import "PKTClient.h"
#import "PKTMacros.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";
static char * const kRequestProcessingQueueLabel = "com.podio.PodioKit.PKTHTTPClient.responseProcessingQueue";

static NSString * const PodioKitErrorDomain = @"PodioKitErrorDomain";

typedef NS_ENUM(NSUInteger, PKTErrorCode) {
  PKTErrorCodeUnknown = 1000,
  PKTErrorCodeRequestFailed,
};

@interface PKTHTTPClient ()

@property (nonatomic, strong, readonly) NSURLSession *session;
@property (nonatomic, strong, readonly) dispatch_queue_t responseProcessingQueue;

@end

@implementation PKTHTTPClient

@synthesize session = _session;
@synthesize requestSerializer = _requestSerializer;
@synthesize responseSerializer = _responseSerializer;

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  _baseURL = [[NSURL alloc] initWithString:kDefaultBaseURLString];
  _responseProcessingQueue = dispatch_queue_create(kRequestProcessingQueueLabel, DISPATCH_QUEUE_CONCURRENT);
  _requestSerializer = [PKTRequestSerializer new];
  _responseSerializer = [PKTResponseSerializer new];
  
  NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
  sessionConfig.HTTPShouldUsePipelining = YES;
  
  _session = [NSURLSession sessionWithConfiguration:sessionConfig];
  
  return self;
}

#pragma mark - Public

//- (AFHTTPRequestOperation *)operationWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
//  NSURLRequest *urlRequest = [(PKTRequestSerializer *)self.requestSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
//  
//  AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
//    NSUInteger statusCode = operation.response.statusCode;
//    PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:statusCode body:responseObject];
//    
//    if (completion) completion(response, nil);
//  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//    NSUInteger statusCode = operation.response.statusCode;
//    PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:statusCode body:operation.responseObject];
//    
//    if (completion) completion(response, error);
//  }];
//  
//  // If this is a download request with a provided local file path, configure an output stream instead
//  // of buffering the data in memory.
//  if (request.method == PKTRequestMethodGET && request.fileData.filePath) {
//    operation.outputStream = [NSOutputStream outputStreamToFileAtPath:request.fileData.filePath append:NO];
//  }
//  
//  return operation;
//}

- (NSURLSessionTask *)taskForRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  // TODO: Handle upload/download as well
  
  NSURLRequest *URLRequest = [self.requestSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  
  NSURLSessionTask *task = [self.session dataTaskWithRequest:URLRequest completionHandler:^(NSData *data, NSURLResponse *URLResponse, NSError *error) {
    if (!completion) return;

    dispatch_async(self.responseProcessingQueue, ^{
      id responseObject = [self.responseSerializer responseObjectForURLResponse:URLResponse data:data];
      
      dispatch_async(dispatch_get_main_queue(), ^{
        NSUInteger statusCode = [URLResponse isKindOfClass:[NSHTTPURLResponse class]] ? [(NSHTTPURLResponse *)URLResponse statusCode] : 0;
        PKTResponse *response = [[PKTResponse alloc] initWithStatusCode:statusCode body:responseObject];

        // NSURLSession reports URL level errors, but does not generate errors for non-2xx status codes.
        // Therefore we need to create our own error.
        NSError *finalError = error;
        if (!finalError && (statusCode < 200 || statusCode > 299)) {
          finalError = [NSError errorWithDomain:PodioKitErrorDomain code:PKTErrorCodeRequestFailed userInfo:nil];
        }
        
        completion(response, finalError);
      });
    });
  }];
  
  return task;
}

@end
