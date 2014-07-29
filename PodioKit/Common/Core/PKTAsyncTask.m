//
//  PKTAsyncTask.m
//  PodioFoundation
//
//  Created by Sebastian Rehnby on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAsyncTask.h"

typedef NS_ENUM(NSUInteger, PKTAsyncTaskState) {
  PKTAsyncTaskStatePending = 0,
  PKTAsyncTaskStateFinished,
  PKTAsyncTaskStateErrored,
  PKTAsyncTaskStateCancelled,
};

@interface PKTAsyncTask ()

@property (readwrite) PKTAsyncTaskState state;
@property (strong) id result;
@property (strong) NSMutableArray *finishCallbacks;
@property (strong) NSMutableArray *errorCallbacks;
@property (strong) NSMutableArray *cancelCallbacks;
@property (strong) NSLock *stateLock;

- (void)finishWithResult:(id)result;
- (void)failWithError:(NSError *)error;

@end

@interface PKTAsyncTaskResolver ()

// Make the task reference strong to make sure that if the resolver lives
// on (in a completion handler for example), the task does as well.
@property (strong) PKTAsyncTask *task;

@end

@implementation PKTAsyncTask

- (instancetype)init {
  self = [super init];
  if (!self) return nil;
  
  _state = PKTAsyncTaskStatePending;
  _finishCallbacks = [NSMutableArray new];
  _errorCallbacks = [NSMutableArray new];
  _cancelCallbacks = [NSMutableArray new];
  _stateLock = [NSLock new];
  
  return self;
}

+ (instancetype)taskForBlock:(PKTAsyncTaskResolveBlock)block {
  PKTAsyncTaskResolver *resolver = [PKTAsyncTaskResolver new];
  PKTAsyncTaskCancelBlock cancelBlock = block(resolver);
  
  PKTAsyncTask *task = [self new];
  resolver.task = task;
  
  if (cancelBlock) {
    [task onCancel:^{
      cancelBlock();
    }];
  }
  
  return task;
}

#pragma mark - Properties

- (BOOL)isFinished {
  return self.state == PKTAsyncTaskStateFinished;
}

- (BOOL)errored {
  return self.state == PKTAsyncTaskStateErrored;
}

- (BOOL)isCancelled {
  return self.state == PKTAsyncTaskStateCancelled;
}

#pragma mark - KVO

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSMutableSet *keyPaths = [[super keyPathsForValuesAffectingValueForKey:key] mutableCopy];
  
  NSArray *keysAffectedByState = @[
                                   NSStringFromSelector(@selector(isFinished)),
                                   NSStringFromSelector(@selector(errored)),
                                   NSStringFromSelector(@selector(isCancelled))
                                   ];
  
  if ([keysAffectedByState containsObject:key]) {
		[keyPaths addObject:NSStringFromSelector(@selector(state))];
  }
  
	return [keyPaths copy];
}

#pragma mark - Register callbacks

- (instancetype)onFinish:(void (^)(id x))finishBlock {
  NSParameterAssert(finishBlock);
  
  [self performSynchronizedBlock:^{
    if (self.finished) {
      finishBlock(self.result);
    } else {
      [self.finishCallbacks addObject:[finishBlock copy]];
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

- (instancetype)onCancel:(void (^)(void))cancelBlock {
  NSParameterAssert(cancelBlock);
  
  [self performSynchronizedBlock:^{
    if (self.cancelled) {
      cancelBlock();
    } else {
      [self.cancelCallbacks addObject:[cancelBlock copy]];
    }
  }];
  
  return self;
}

#pragma mark - Resolve

- (void)finishWithResult:(id)result {
  [self performSynchronizedBlock:^{
    if (self.finished) return;
    
    self.result = result;
    self.state = PKTAsyncTaskStateFinished;
    
    for (PKTAsyncTaskFinishBlock callback in self.finishCallbacks) {
      dispatch_async(dispatch_get_main_queue(), ^{
        callback(self.result);
      });
    }
    
    [self.finishCallbacks removeAllObjects];
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
    
    [self.errorCallbacks removeAllObjects];
  }];
}

- (void)cancel {
  [self performSynchronizedBlock:^{
    if (self.cancelled) return;
    
    self.state = PKTAsyncTaskStateCancelled;
    
    for (PKTAsyncTaskCancelBlock callback in self.cancelCallbacks) {
      dispatch_async(dispatch_get_main_queue(), ^{
        callback();
      });
    }
    
    [self.cancelCallbacks removeAllObjects];
  }];
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

- (void)finishWithResult:(id)result {
  [self.task finishWithResult:result];
  self.task = nil;
}

- (void)failWithError:(NSError *)error {
  [self.task failWithError:error];
  self.task = nil;
}

@end