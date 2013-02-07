//
//  PKCommentAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/28/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKCommentAPI : PKBaseAPI

+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType fileIds:(NSArray *)fileIds;

@end
