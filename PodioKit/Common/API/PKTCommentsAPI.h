//
//  PKTCommentsAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTConstants.h"

@interface PKTCommentsAPI : PKTBaseAPI

+ (PKTRequest *)requestToAddCommentToObjectWithReferenceID:(NSUInteger)referenceID referenceType:(PKTReferenceType)referenceType value:(NSString *)value files:(NSArray *)files embedID:(NSUInteger)embedID embedURL:(NSURL *)embedURL;

@end
