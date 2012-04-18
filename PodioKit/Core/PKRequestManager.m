//
//  PKSyncManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKRequestManager.h"
#import "NSString+Hash.h"

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

- (PKRequestOperation *)performRequest:(PKRequest *)request completion:(PKRequestCompletionBlock)completion {
  PKAssert(self.mappingCoordinator != nil, @"No mapping coordinator set.");
  
  NSString *urlString = [self.apiClient URLStringForPath:request.uri parameters:request.parameters];
  PKRequestOperation *operation = [PKRequestOperation operationWithURLString:urlString method:request.method body:request.body];
  operation.requestCompletionBlock = completion;
  operation.allowsConcurrent = request.allowsConcurrent;
  
  if (request.objectMapping != nil) {
    PKObjectMapper *mapper = [self.mappingCoordinator objectMapper];
    mapper.mapping = request.objectMapping;
    mapper.mappingBlock = request.mappingBlock;
    mapper.offset = request.offset;
    mapper.scopePredicate = request.scopePredicate;
    operation.objectMapper = mapper;
  }
  
  // Enqueue
  BOOL success = [self.apiClient addRequestOperation:operation];
  
  return success ? operation : nil;
}

@end
