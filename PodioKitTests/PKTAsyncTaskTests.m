//
//  PKTAsyncTaskTests.m
//  PodioFoundation
//
//  Created by Sebastian Rehnby on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTAsyncTask.h"

@interface PKTAsyncTaskTests : XCTestCase

@end

@implementation PKTAsyncTaskTests

- (void)testCanOnlySucceed {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@"Value1"];
  }];
  
  __block BOOL finished = NO;
  __block BOOL errored = NO;
  
  [task onSuccess:^(id x) {
    finished = YES;
  }];
  
  [task onError:^(NSError *error) {
    errored = YES;
  }];
  
  expect(finished).will.beTruthy();
  expect(errored).notTo.beTruthy();
}

- (void)testCanOnlyError {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver failWithError:[NSError errorWithDomain:@"PodioFoundation" code:0 userInfo:nil]];
  }];
  
  __block BOOL finished = NO;
  __block BOOL errored = NO;
  
  [task onSuccess:^(id x) {
    finished = YES;
  }];
  
  [task onError:^(NSError *error) {
    errored = YES;
  }];
  
  expect(errored).will.beTruthy();
  expect(finished).notTo.beTruthy();
}

- (void)testComplete {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@"Value1"];
  }];
  
  __block id taskResult = nil;
  __block NSError *taskError = nil;
  
  [task onComplete:^(id result, NSError *error) {
    taskResult = result;
    taskError = error;
  }];

  expect(taskResult).willNot.beNil();
  expect(taskError).to.beNil();
}

- (void)testCanOnlyFinishOnlyOnce {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@"Value1"];
    [resolver succeedWithResult:@"Value2"];
  }];
  
  __block id value = NO;
  [task onSuccess:^(id x) {
    value = x;
  }];
  
  expect(value).will.equal(@"Value1");
}

- (void)testCanOnlyFinishForMultipleCallbacks {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@[]];
  }];
  
  __block BOOL completed1 = NO;
  [task onSuccess:^(id x) {
    completed1 = YES;
  }];
  
  __block BOOL completed2 = NO;
  [task onSuccess:^(id x) {
    completed2 = YES;
  }];
  
  expect(completed1).will.beTruthy();
  expect(completed2).will.beTruthy();
}

- (void)testMap {
  PKTAsyncTask *arrayTask = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@[@1, @2, @3]];
  }];
  
  PKTAsyncTask *task = [arrayTask map:^id(NSArray *array) {
    return @10;
  }];
  
  __block id value = nil;
  [task onSuccess:^(id result) {
    value = result;
  }];
  
  expect(value).will.equal(@10);
}

- (void)testWhen {
  PKTAsyncTask *task1 = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@1];
  }];
  PKTAsyncTask *task2 = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@2];
  }];
  
  __block id mergedResult = nil;
  [[PKTAsyncTask when:@[task1, task2]] onSuccess:^(id result) {
    mergedResult = result;
  }];
  
  expect(mergedResult).will.equal(@[@1, @2]);
}

- (void)testFailingFirstOfWhenTasksWillFailOuterTask {
  PKTAsyncTask *task1 = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver failWithError:[NSError errorWithDomain:@"PodioKit" code:0 userInfo:nil]];
  }];
  
  PKTAsyncTask *task2 = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@2];
  }];

  __block BOOL task2Failed = NO;
  [task2 onError:^(NSError *error) {
    task2Failed = YES;
  }];
  
  PKTAsyncTask *mergedTask = [PKTAsyncTask when:@[task1, task2]];
  
  __block NSError *mergedError = nil;
  [mergedTask onError:^(NSError *error) {
    mergedError = error;
  }];
  
  expect(mergedError).willNot.beNil();
}

- (void)testFlattenMap {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@3];
  }];
  
  PKTAsyncTask *pipedTask = [task flattenMap:^PKTAsyncTask *(NSNumber *num) {
    return [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
      NSUInteger number =  [num unsignedIntegerValue];
      [resolver succeedWithResult:@(number * number)];
    }];
  }];
  
  __block NSNumber *pipedTaskValue = nil;
  [pipedTask onSuccess:^(id result) {
    pipedTaskValue = result;
  }];
  
  expect(pipedTaskValue).will.equal(@9);
}

- (void)testCancellingFlattenMappedTaskShouldCancelOriginalTasks {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@3];
  }];
  
  PKTAsyncTask *pipedTask = [task flattenMap:^PKTAsyncTask *(NSNumber *num) {
    return [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
      NSUInteger number =  [num unsignedIntegerValue];
      [resolver succeedWithResult:@(number * number)];
    }];
  }];

  __block NSError *taskError = nil;
  [task onError:^(NSError *error) {
    taskError = error;
  }];
  
  __block NSError *pipedError = nil;
  [pipedTask onError:^(NSError *error) {
   pipedError = error;
  }];
  
  [pipedTask cancel];
   
  expect(pipedError).willNot.beNil();
  expect(taskError).willNot.beNil();
}

#pragma mark - Helpers

- (PKTAsyncTask *)taskWithCompletion:(void (^)(PKTAsyncTaskResolver *resolver))completion {
  return [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
          if (completion) completion(resolver);
        });
      });
    });
    
    return ^{
      [resolver failWithError:[NSError errorWithDomain:@"PodioKit" code:0 userInfo:nil]];
    };
  }];
}

@end
