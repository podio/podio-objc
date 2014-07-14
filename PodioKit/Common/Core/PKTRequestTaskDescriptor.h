//
//  PKTRequestTaskDescriptor.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTHTTPClient.h"

@interface PKTRequestTaskDescriptor : NSObject

@property (nonatomic, strong, readonly) PKTRequest *request;
@property (nonatomic, copy, readonly) PKTRequestCompletionBlock completionHandler;
@property (nonatomic, strong, readonly) NSURLSessionTask *task;
@property (nonatomic, assign, readonly, getter = isCancelled) BOOL cancelled;

+ (instancetype)descriptorWithRequest:(PKTRequest *)request completion:(PKTRequestCompletionBlock)completion;

/**
 *  Starts the task immediately using the provided client. This method will get a new task from the provide client 
 *  and immediately call resume on it.
 *
 *  @param client The client to start the task.
 */
- (void)startWithClient:(PKTHTTPClient *)client;

/**
 *  Starts the task immediately using the provided client. This method will get a new task from the provide client
 *  and immediately call cancel on it.
 *
 *  @param client The client to cancel the task.
 */
- (void)cancelWithClient:(PKTHTTPClient *)client;

/**
 *  Marks the task to be cancelled immediately after being started.
 */
- (void)cancel;

@end
