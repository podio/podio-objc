//
//  PKCommentAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/28/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKCommentAPI : PKBaseAPI

+ (PKRequest *)requestForPostCommentWithText:(NSString *)text referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;

@end
