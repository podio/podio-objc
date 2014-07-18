//
//  PKGrantAPI.h
//  PodioKit
//
//  Created by Romain Briche on 18/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <PodioKit/PodioKit.h>

@interface PKGrantAPI : PKBaseAPI

+ (PKRequest *)requestForOwnGrantsOnOrganizationWithId:(NSUInteger)orgId;
+ (PKRequest *)requestForGrantOnObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestForGrantCountOnObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestToCreateGrantOnObjectWithUserIds:(NSArray *)userIds message:(NSString *)message action:(PKGrantAction)action referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestToRemoveGrantOnObjectWithUserId:(NSUInteger)userId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;

@end
