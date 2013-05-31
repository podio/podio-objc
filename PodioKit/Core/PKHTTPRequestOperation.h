//
//  PKHTTPRequestOperation.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/30/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "PKRequest.h"

// Notifications
extern NSString * const PKHTTPRequestOperationFinished;
extern NSString * const PKHTTPRequestOperationFailed;

extern NSString * const PKHTTPRequestOperationKey;
extern NSString * const PKHTTPRequestResultKey;
extern NSString * const PKHTTPRequestErrorKey;

@class PKObjectMapper;

@interface PKHTTPRequestOperation : AFHTTPRequestOperation

@property (strong) PKObjectMapper *objectMapper;
@property (copy) NSArray *objectDataPathComponents;

+ (PKHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request completion:(PKRequestCompletionBlock)completion;

- (void)setRequestCompletionBlock:(PKRequestCompletionBlock)requestCompletionBlock;
- (void)completeWithResult:(PKRequestResult *)result error:(NSError *)error;

- (void)setValue:(NSString *)value forHeader:(NSString *)header;

@end
