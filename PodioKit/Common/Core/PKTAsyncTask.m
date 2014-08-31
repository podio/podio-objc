//
//  PKTAsyncTask.m
//  PodioFoundation
//
//  Created by Sebastian Rehnby on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAsyncTask.h"
#import "PKTMacros.h"
#import "NSArray+PKTAdditions.h"

typedef NS_ENUM(NSUInteger, PKTAsyncTaskState) {
  PKTAsyncTaskStatePending = 0,
  PKTAsyncTaskStateSucceeded,
  PKTAsyncTaskStateErrored,
};

@interface PKTAsyncTask ()

@property (readwrite) PKTAsyncTaskState state;
@property (strong) id result;
@property (strong, readonly) NSMutableArray *completeCallbacks;
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

@implementation PKTAsyncTask {

  dispatch_once_t _resolvedOnceToken;
}

- (instancetype)initWithCancelBlock:(PKTAsyncTaskCancelBlock)cancelBlock {
  self = [super init];
  if (!self) return nil;
  
  _state = PKTAsyncTaskStatePending;
  _completeCallbacks = [NSMutableArray new];
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

+ (instancetype)when:(NSArray *)tasks {
  return [self taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    NSMutableSet *pendingTasks = [NSMutableSet setWithArray:tasks];
    
    NSUInteger taskCount = [tasks count];
    NSMutableDictionary *results = [NSMutableDictionary new];
    
    // We need a lock to synchronize access to the results dictionary and remaining tasks set.
    NSLock *lock = [NSLock new];
    
    void (^cancelRemainingBlock) (void) = ^{
      // Clear the backlog of tasks and cancel remaining ones.
      [lock lock];
      
      NSSet *tasksToCancel = [pendingTasks copy];
      [pendingTasks removeAllObjects];
      
      for (PKTAsyncTask *task in tasksToCancel) {
        [task cancel];
      }
      
      [lock unlock];
    };
    
    NSUInteger pos = 0;
    for (PKTAsyncTask *task in tasks) {
      
      [task onSuccess:^(id result) {
        id res = result ?: [NSNull null];
        
        [lock lock];
        
        // Add the result to the results dictionary at the original position of the task,
        // and remove the task from the list of pending tasks to avoid it from being
        // cancelled if the combined task is cancelled later.
        results[@(pos)] = res;
        [pendingTasks removeObject:task];
        
        [lock unlock];
        
        if ([pendingTasks count] == 0) {
          // All tasks have completed, collect the results and sort them in the
          // tasks' original ordering
          NSArray *positions = [NSArray pkt_arrayFromRange:NSMakeRange(0, taskCount)];
          NSArray *orderedResults = [positions pkt_mappedArrayWithBlock:^id(NSNumber *pos) {
            return results[pos];
          }];
          
          [resolver succeedWithResult:orderedResults];
        }
      } onError:^(NSError *error) {
        cancelRemainingBlock();
        
        [resolver failWithError:error];
      }];
      
      ++pos;
    }
    
    return cancelRemainingBlock;
  }];
}

- (instancetype)then:(PKTAsyncTaskThenBlock)thenBlock {
  return [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    [self onSuccess:^(id result) {
      thenBlock(result, nil);
      [resolver succeedWithResult:result];
    } onError:^(NSError *error) {
      thenBlock(nil, error);
      [resolver failWithError:error];
    }];
    
    PKT_WEAK_SELF weakSelf = self;
    
    return ^{
      [weakSelf cancel];
    };
  }];
}

- (instancetype)map:(id (^)(id result))block {
  return [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    
    [self onSuccess:^(id result) {
      id mappedResult = block ? block(result) : result;
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

- (instancetype)flattenMap:(PKTAsyncTask *(^)(id result))block {
  NSParameterAssert(block);
  
  return [[self class] taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    __block PKTAsyncTask *pipedTask = nil;
    
    [self onSuccess:^(id result1) {
      pipedTask = block(result1);
      
      [pipedTask onSuccess:^(id result2) {
        [resolver succeedWithResult:result2];
      } onError:^(NSError *error) {
        [resolver failWithError:error];
      }];
    } onError:^(NSError *error) {
      [resolver failWithError:error];
    }];
    
    // Cancel both tasks in the case of the parent task being cancelled.
    PKT_WEAK_SELF weakSelf = self;
    PKT_WEAK(pipedTask) weakPipedTask = pipedTask;
    
    return ^{
      [weakSelf cancel];
      [weakPipedTask cancel];
    };
  }];
}

#pragma mark - Properties

- (BOOL)completed {
  return self.state != PKTAsyncTaskStatePending;
}

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
                                   NSStringFromSelector(@selector(completed)),
                                   NSStringFromSelector(@selector(succeeded)),
                                   NSStringFromSelector(@selector(errored))
                                   ];
  
  if ([keysAffectedByState containsObject:key]) {
		[keyPaths addObject:NSStringFromSelector(@selector(state))];
  }
  
	return [keyPaths copy];
}

#pragma mark - Register callbacks

- (instancetype)onComplete:(PKTAsyncTaskCompleteBlock)completeBlock {
  NSParameterAssert(completeBlock);
  
  [self performSynchronizedBlock:^{
    if (self.succeeded) {
      completeBlock(self.result, nil);
    } else if (self.errored) {
      completeBlock(nil, self.result);
    } else {
      [self.completeCallbacks addObject:[completeBlock copy]];
    }
  }];
  
  return self;
}

- (instancetype)onSuccess:(void (^)(id x))successBlock {
  NSParameterAssert(successBlock);
  
  [self performSynchronizedBlock:^{
    if (self.completed) {
      if (self.succeeded) {
        successBlock(self.result);
      }
    } else {
      [self.successCallbacks addObject:[successBlock copy]];
    }
  }];
  
  return self;
}

- (instancetype)onError:(void (^)(NSError *error))errorBlock {
  NSParameterAssert(errorBlock);
  
  [self performSynchronizedBlock:^{
    if (self.completed) {
      if (self.errored) {
        errorBlock(self.result);
      }
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
  [self resolveWithState:PKTAsyncTaskStateSucceeded result:result];
}

- (void)failWithError:(NSError *)error {
  [self resolveWithState:PKTAsyncTaskStateErrored result:error];
}

- (void)resolveWithState:(PKTAsyncTaskState)state result:(id)result {
  dispatch_once(&_resolvedOnceToken, ^{
    [self performSynchronizedBlock:^{
      self.state = state;
      self.result = result;
      
      if (state == PKTAsyncTaskStateSucceeded) {
        [self performSuccessCallbacksWithResult:result];
        [self performCompleteCallbacksWithResult:result error:nil];
      } else if (state == PKTAsyncTaskStateErrored) {
        [self performErrorCallbacksWithError:result];
        [self performCompleteCallbacksWithResult:nil error:result];
      }
      
      [self removeAllCallbacks];
    }];
  });
}

- (void)performSuccessCallbacksWithResult:(id)result {
  for (PKTAsyncTaskSuccessBlock callback in self.successCallbacks) {
    dispatch_async(dispatch_get_main_queue(), ^{
      callback(self.result);
    });
  }
}

- (void)performErrorCallbacksWithError:(NSError *)error {
  for (PKTAsyncTaskErrorBlock callback in self.errorCallbacks) {
    dispatch_async(dispatch_get_main_queue(), ^{
      callback(self.result);
    });
  }
}

- (void)performCompleteCallbacksWithResult:(id)result error:(NSError *)error {
  for (PKTAsyncTaskCompleteBlock callback in self.completeCallbacks) {
    dispatch_async(dispatch_get_main_queue(), ^{
      callback(result, error);
    });
  }
}

- (void)removeAllCallbacks {
  [self.successCallbacks removeAllObjects];
  [self.errorCallbacks removeAllObjects];
  [self.completeCallbacks removeAllObjects];
  self.cancelBlock = nil;
}

- (void)cancel {
  if (self.cancelBlock) {
    self.cancelBlock();
    self.cancelBlock = nil;
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