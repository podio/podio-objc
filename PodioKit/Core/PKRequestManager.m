//
//  PKSyncManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKRequestManager.h"

@interface PKRequestManager ()

@end

@implementation PKRequestManager

@synthesize apiClient = apiClient_;
@synthesize mappingCoordinator = mappingCoordinator_;

+ (PKRequestManager *)sharedManager {
  static PKRequestManager *sharedInstance = nil;
  static dispatch_once_t pred;
  
  dispatch_once(&pred, ^{
    sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}

- (id)init {
  @synchronized(self) {
    self = [super init];
    
    // Custom initialization
    apiClient_ = nil;
    
    return self;
  }
}

#pragma mark - Impl

- (PKAPIClient *)apiClient {
  return apiClient_ != nil ? apiClient_ : [PKAPIClient sharedClient];
}

- (void)configureWithClient:(PKAPIClient *)client mappingCoordinator:(PKMappingCoordinator *)coordinator {
  apiClient_ = client;
  mappingCoordinator_ = coordinator;  
}

#pragma mark - Request

- (PKHTTPRequestOperation *)performRequest:(PKRequest *)request completion:(PKRequestCompletionBlock)completion {
  NSURLRequest *urlRequest = [self.apiClient requestWithMethod:request.method
                                                          path:request.uri
                                                    parameters:request.parameters
                                                          body:request.body];
  
  PKHTTPRequestOperation *operation = [self.apiClient operationWithRequest:urlRequest completion:completion];
  operation.requestCompletionBlock = completion;
  operation.objectDataPathComponents = request.objectDataPathComponents;
  
  if (request.objectMapping != nil && self.mappingCoordinator != nil) {
    PKObjectMapper *mapper = [self.mappingCoordinator objectMapper];
    mapper.mapping = request.objectMapping;
    mapper.mappingBlock = request.mappingBlock;
    mapper.offset = request.offset;
    mapper.scopePredicate = request.scopePredicate;
    operation.objectMapper = mapper;
  }
  
  BOOL success = [self.apiClient performOperation:operation];
  
  return success ? operation : nil;
}

@end
