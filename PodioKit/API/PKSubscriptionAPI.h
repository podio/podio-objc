//
//  PKSubscriptionAPI.h
//  PodioKit
//
//  Created by Romain Briche on 17/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKSubscriptionAPI : PKBaseAPI

+ (PKRequest *)requestToSubscribeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestToUnsubscribeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestForSubscriptionsWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;

@end
