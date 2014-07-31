//
//  PKTAsyncTask.m
//  PodioFoundation
//
//  Created by Sebastian Rehnby on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAsyncTask.h"
#import "PKTMacros.h"

typedef NS_ENUM(NSUInteger, PKTAsyncTaskState) {
  PKTAsyncTaskStatePending = 0,
  PKTAsyncTaskStateSucceeded,
  PKTAsyncTaskStateErrored,
};

@interface PKTAsyncTask ()

@property (readwrite) PKTAsyncTaskState state;
@property (strong) id result;
@property (strong, readonly) NSMutableArray *successCallbacks;
@property (strong, readonly) NSMutableArray *errorCallbacks;
@property (copy) PKTAsyncTaskCancelBlock cancelBlock;
@property (strong) NSLock *stateLock;

- (void)succeedWithResult:(id)result;
- (void)failWithError:(NSError *)error;

@end

@interface PKTAsyncTaskResolver ()

// Make the task reference strong to make sure that if the resolver lives
// on (in a completion handler for example), the task does as well.
@property (strong) PKTAsyncTask *task;

@end

@implementation PKTAsyncTask

- (instancetype)initWithCancelBlock:(PKTAsyncTaskCancelBlock)cancelBlock {
  self = [super init];
  if (!self) return nil;
  
  _state = PKTAsyncTaskStatePending;
  _successCallbacks = [NSMutableArray new];
  _errorCallbacks = [NSMutableArray new];
  _stateLock = [NSLock new];
  _cancelBlock = [cancelBlock copy];
  
  return self;
}

+ (instancetype)taskForBlock:(PKTAsyncTaskResolveBlock)block {
  PKTAsyncTaskResolver *resolver = [PKTAsyncTaskResolver new];
  PKTAsyncTaskCancelBlock cancelBlock = block(resolver);
  
  PKTAsyncTask *task = [[self alloc] initWithCancelBlock:cancelBlock];
  resolver.task = task;
  
  return task;
}

- (instancetype)taskByMappingResult:(id (^)(id result))mappingBlock {
  return [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    
    [self onSuccess:^(id result) {
      id mappedResult = mappingBlock ? mappingBlock(result) : result;
      [resolver succeedWithResult:mappedResult];
    } onError:^(NSError *error) {
      [resolver failWithError:error];
    }];
    
    PKT_WEAK_SELF weakSelf = self;
    
    return ^{
      [weakSelf cancel];
    };
  }];
}

#pragma mark - Properties

- (BOOL)succeeded {
  return self.state == PKTAsyncTaskStateSucceeded;
}

- (BOOL)errored {
  return self.state == PKTAsyncTaskStateErrored;
}

#pragma mark - KVO

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
  
  NSArray *keysAffectedByState = @[
                                   NSStringFromSelector(@selector(succeeded)),
                                   NSStringFromSelector(@selector(errored)),
                                   NSStringFromSelector(@selector(isCancelled))
                                   ];
  
  if ([keysAffectedByState containsObject:key]) {
		[keyPaths addObject:NSStringFromSelector(@selector(state))];
  }
  
	return [keyPaths copy];
}

#pragma mark - Register callbacks

- (instancetype)onSuccess:(void (^)(id x))successBlock {
  NSParameterAssert(successBlock);
  
  [self performSynchronizedBlock:^{
    if (self.succeeded) {
      successBlock(self.result);
    } else {
      [self.successCallbacks addObject:[successBlock copy]];
    }
  }];
  
  return self;
}

- (instancetype)onError:(void (^)(NSError *error))errorBlock {
  NSParameterAssert(errorBlock);
  
  [self performSynchronizedBlock:^{
    if (self.errored) {
      errorBlock(self.result);
    } else {
      [self.errorCallbacks addObject:[errorBlock copy]];
    }
  }];
  
  return self;
}

- (instancetype)onSuccess:(PKTAsyncTaskSuccessBlock)successBlock onError:(PKTAsyncTaskErrorBlock)errorBlock {
  [self onSuccess:successBlock];
  [self onError:errorBlock];
  
  return self;
}

#pragma mark - Resolve

- (void)succeedWithResult:(id)result {
  [self performSynchronizedBlock:^{
    if (self.succeeded) return;
    
    self.result = result;
    self.state = PKTAsyncTaskStateSucceeded;
    
    for (PKTAsyncTaskSuccessBlock callback in self.successCallbacks) {
      dispatch_async(dispatch_get_main_queue(), ^{
        callback(self.result);
      });
    }
    
    [self removeAllCallbacks];
  }];
}

- (void)failWithError:(NSError *)error {
  [self performSynchronizedBlock:^{
    if (self.errored) return;
    
    self.result = error;
    self.state = PKTAsyncTaskStateErrored;
    
    for (PKTAsyncTaskErrorBlock callback in self.errorCallbacks) {
      dispatch_async(dispatch_get_main_queue(), ^{
        callback(self.result);
      });
    }
    
    [self removeAllCallbacks];
  }];
}

- (void)removeAllCallbacks {
  [self.successCallbacks removeAllObjects];
  [self.errorCallbacks removeAllObjects];
  self.cancelBlock = nil;
}

- (void)cancel {
  if (self.cancelBlock) {
    self.cancelBlock();
  }
}

#pragma mark - Helpers

- (void)performSynchronizedBlock:(void (^)(void))block {
  NSParameterAssert(block);
  
  [self.stateLock lock];
  block();
  [self.stateLock unlock];
}

@end

@implementation PKTAsyncTaskResolver

- (void)succeedWithResult:(id)result {
  [self.task succeedWithResult:result];
  self.task = nil;
}

- (void)failWithError:(NSError *)error {
  [self.task failWithError:error];
  self.task = nil;
}

@end