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

- (void)testCanOnlyFinish {
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

- (void)testWrappingTasks {
  PKTAsyncTask *arrayTask = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver succeedWithResult:@[@1, @2, @3]];
  }];
  
  PKTAsyncTask *task = [arrayTask taskByMappingResult:^id(NSArray *array) {
    return @10;
  }];
  
  __block id value = nil;
  [task onSuccess:^(id result) {
    value = result;
  }];
  
  expect(value).will.equal(@10);
}

#pragma mark - Helpers

- (PKTAsyncTask *)taskWithCompletion:(void (^)(PKTAsyncTaskResolver *resolver))completion {
  return [PKTAsyncTask taskForBlock:^PKTAsyncTaskCancelBlock(PKTAsyncTaskResolver *resolver) {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      dispatch_async(dispatch_get_main_queue(), ^{
        if (completion) completion(resolver);
      });
    });
    
    return nil;
  }];
}

@end
