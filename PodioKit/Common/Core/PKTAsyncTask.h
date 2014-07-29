//
//  PKTAsyncTask.h
//  PodioFoundation
//
//  Created by Sebastian Rehnby on 28/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKTAsyncTaskResolver;

typedef void (^PKTAsyncTaskFinishBlock) (id result);
typedef void (^PKTAsyncTaskErrorBlock) (NSError *error);
typedef void (^PKTAsyncTaskCancelBlock) (void);
typedef PKTAsyncTaskCancelBlock (^PKTAsyncTaskResolveBlock) (PKTAsyncTaskResolver *resolver);

@interface PKTAsyncTask : NSObject

@property (readonly, getter = isFinished) BOOL finished;
@property (readonly) BOOL errored;
@property (readonly, getter = isCancelled) BOOL cancelled;

+ (instancetype)taskForBlock:(PKTAsyncTaskResolveBlock)block;

- (instancetype)onFinish:(PKTAsyncTaskFinishBlock)finishBlock;
- (instancetype)onError:(PKTAsyncTaskErrorBlock)errorBlock;
- (instancetype)onCancel:(PKTAsyncTaskCancelBlock)cancelBlock;

- (void)cancel;

@end

@interface PKTAsyncTaskResolver : NSObject

- (void)finishWithResult:(id)result;
- (void)failWithError:(NSError *)error;

@end