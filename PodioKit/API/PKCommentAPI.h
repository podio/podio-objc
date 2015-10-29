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
+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType fileIds:(NSArray *)fileIds alertInvite:(BOOL)alertInvite;
+ (PKRequest *)requestToDeleteCommentWithId:(NSUInteger)commentId;
+ (PKRequest *)requestToUpdateCommentWithId:(NSUInteger)commentId value:(NSString *)value fileIds:(NSArray *)fileIds;

@end
