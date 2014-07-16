//
//  PKTRequestTaskDescriptor.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTRequestTaskDescriptor.h"

@interface PKTRequestTaskDescriptor ()

@property (nonatomic, strong, readwrite) NSURLSessionTask *task;

@end

@implementation PKTRequestTaskDescriptor

- (instancetype)initWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  self = [super init];
  if (!self) return nil;
  
  _request = request;
  _completionHandler = [completion copy];
  
  return self;
}

+ (instancetype)descriptorWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion {
  return [[self alloc] initWithRequest:request completion:completion];
}

- (void)setTask:(NSURLSessionTask *)task {
  _task = task;
  
  // Cancel immediately if this descriptor has been cancelled previously.
  if (self.cancelled) {
    [_task cancel];
  }
}

#pragma mark - Public

- (void)updateTaskFromClient:(PKTHTTPClient *)client {
  if (!self.task) {
    self.task = [client taskForRequest:self.request completion:self.completionHandler];
  };
}

- (void)startWithClient:(PKTHTTPClient *)client {
  [self updateTaskFromClient:client];
  [self.task resume];
}

- (void)cancelWithClient:(PKTHTTPClient *)client {
  [self updateTaskFromClient:client];
  [self.task cancel];
}

- (void)cancel {
  @synchronized(self) {
    if (!self.cancelled) {
      _cancelled = YES;
      [self.task cancel];
    }
  }
}

@end
