//
//  PKRatingAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"

@interface PKRatingAPI : PKBaseAPI

+ (PKRequest *)requestForLikeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestForUnlikeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;

@end
