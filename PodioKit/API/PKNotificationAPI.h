//
//  PKNotificationsAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/11/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKRequest.h"
#import "PKBaseAPI.h"


@interface PKNotificationAPI : PKBaseAPI

+ (PKRequest *)requestForNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo options:(NSDictionary *)options;
+ (PKRequest *)requestForNewNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo;
+ (PKRequest *)requestForViewedNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo;
+ (PKRequest *)requestForStarredNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo;
+ (PKRequest *)requestForSentNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo;

+ (PKRequest *)requestForNotificationWithNotificationId:(NSUInteger)notificationId;

+ (PKRequest *)requestToMarkNotificationAsViewedWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType;
+ (PKRequest *)requestToMarkAllNotificationsAsViewed;

+ (PKRequest *)requestToStarNotificationWithId:(NSUInteger)notificationId;
+ (PKRequest *)requestToUnstarNotificationWithId:(NSUInteger)notificationId;

@end
