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
    [resolver finishWithResult:@"Value1"];
  }];
  
  __block BOOL finished = NO;
  __block BOOL errored = NO;
  __block BOOL cancelled = NO;
  
  [task onFinish:^(id x) {
    finished = YES;
  }];
  
  [task onError:^(NSError *error) {
    errored = YES;
  }];
  
  [task onCancel:^{
    cancelled = YES;
  }];
  
  expect(finished).will.beTruthy();
  expect(errored).notTo.beTruthy();
  expect(cancelled).notTo.beTruthy();
}

- (void)testCanOnlyError {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver failWithError:[NSError errorWithDomain:@"PodioFoundation" code:0 userInfo:nil]];
  }];
  
  __block BOOL finished = NO;
  __block BOOL errored = NO;
  __block BOOL cancelled = NO;
  
  [task onFinish:^(id x) {
    finished = YES;
  }];
  
  [task onError:^(NSError *error) {
    errored = YES;
  }];
  
  [task onCancel:^{
    cancelled = YES;
  }];
  
  expect(errored).will.beTruthy();
  expect(finished).notTo.beTruthy();
  expect(cancelled).notTo.beTruthy();
}

- (void)testCanOnlyCancel {
  PKTAsyncTask *task = [self taskWithCompletion:nil];
  
  __block BOOL finished = NO;
  __block BOOL errored = NO;
  __block BOOL cancelled = NO;
  
  [task onFinish:^(id x) {
    finished = YES;
  }];
  
  [task onError:^(NSError *error) {
    errored = YES;
  }];
  
  [task onCancel:^{
    cancelled = YES;
  }];
  
  [task cancel];
  
  expect(cancelled).will.beTruthy();
  expect(finished).notTo.beTruthy();
  expect(errored).notTo.beTruthy();
}

- (void)testCanOnlyFinishOnlyOnce {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver finishWithResult:@"Value1"];
    [resolver finishWithResult:@"Value2"];
  }];
  
  __block id value = NO;
  [task onFinish:^(id x) {
    value = x;
  }];
  
  expect(value).will.equal(@"Value1");
}

- (void)testCanOnlyFinishForMultipleCallbacks {
  PKTAsyncTask *task = [self taskWithCompletion:^(PKTAsyncTaskResolver *resolver) {
    [resolver finishWithResult:@[]];
  }];
  
  __block BOOL completed1 = NO;
  [task onFinish:^(id x) {
    completed1 = YES;
  }];
  
  __block BOOL completed2 = NO;
  [task onFinish:^(id x) {
    completed2 = YES;
  }];
  
  expect(completed1).will.beTruthy();
  expect(completed2).will.beTruthy();
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
