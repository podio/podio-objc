//
//  PKHTTPRequestOperation.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/30/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "AFHTTPRequestOperation.h"
#import "PKRequest.h"

@class PKObjectMapper;

@interface PKHTTPRequestOperation : AFHTTPRequestOperation

@property (strong) PKObjectMapper *objectMapper;
@property (copy) NSArray *objectDataPathComponents;
@property (nonatomic, copy) PKRequestCompletionBlock requestCompletionBlock;

- (void)setValue:(NSString *)value forHeader:(NSString *)header;

@end
