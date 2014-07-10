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
#import "NSFileManager+PKTAdditions.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";
static char * const kRequestProcessingQueueLabel = "com.podio.podiokit.httpclient.response_processing_queue";

static NSString * const PodioKitErrorDomain = @"PodioKitErrorDomain";

typedef id (^PKTHTTPResponseProcessBlock) (void);

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

- (NSURLSessionTask *)taskForRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  NSURLRequest *URLRequest = [self.requestSerializer URLRequestForRequest:request relativeToURL:self.baseURL];
  
  void (^handlerBlock) (NSData *, NSURLResponse *, NSError *, PKTHTTPResponseProcessBlock) = ^(NSData *data, NSURLResponse *URLResponse, NSError *error, PKTHTTPResponseProcessBlock processBlock){
    if (!completion) return;
    
    dispatch_async(self.responseProcessingQueue, ^{
      // Process response on background queue if needed
      id responseObject = processBlock ? processBlock() : nil;
      
      dispatch_async(dispatch_get_main_queue(), ^{
        // Compose response and return on the main queue
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
  };
  
  NSURLSessionTask *task = nil;
  
  if (request.fileData) {
    task = [self.session downloadTaskWithRequest:URLRequest completionHandler:^(NSURL *location, NSURLResponse *URLResponse, NSError *error) {
      NSError *finalError = error;
      
      if (location && !finalError) {
        // Move the downloaded file from the temp location to the requested save location. This cannot happen in the processing block because it
        // is executed asynchronously and the temporary file will be removed by the task after the execution of this completionHandler.
        [[NSFileManager defaultManager] pkt_moveItemAtURL:location toPath:request.fileData.filePath withIntermediateDirectories:YES error:&finalError];
      }
      
      handlerBlock(nil, URLResponse, finalError, nil);
    }];
  } else {
    task = [self.session dataTaskWithRequest:URLRequest completionHandler:^(NSData *data, NSURLResponse *URLResponse, NSError *error) {
      handlerBlock(data, URLResponse, error, ^{
        return [self.responseSerializer responseObjectForURLResponse:URLResponse data:data];
      });
    }];
  }
  
  return task;
}

@end
