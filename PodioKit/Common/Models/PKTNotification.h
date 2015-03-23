//
//  PKTNotification.h
//  PodioKit
//
//  Created by Romain Briche on 19/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@class PKTByLine, PKTAsyncTask, PKTNotificationsRequestParameters;

@interface PKTNotification : PKTModel

/*
 * The id of the notification
 */
@property (nonatomic, assign, readonly) NSUInteger notificationID;

/*
 * The type of notification
 */
@property (nonatomic, assign, readonly) PKTNotificationType notificationType;

/*
 * The data of the notification, depends on the type of notification
 */
@property (nonatomic, strong, readonly) id notificationObject;

/*
 * The text for the notification
 */
@property (nonatomic, copy, readonly) NSString *text;

/*
 * A short form of the notification text, to be used within an established context
 */
@property (nonatomic, copy, readonly) NSString *textShort;

/*
 * The date and time when the notification was viewed
 */
@property (nonatomic, copy, readonly) NSDate *viewedOn;

/*
 * True if the notification has been viewed, false otherwise
 */
@property (nonatomic, assign, readonly) BOOL viewed;

/*
 * True if the notification is starred, false otherwise
 */
@property (nonatomic, assign, readonly) BOOL starred;

/*
 * The id of the subscription this notification was from, if any
 */
@property (nonatomic, assign, readonly) NSUInteger subscriptionID;

/*
 * The date and time when the notification was created
 */
@property (nonatomic, copy, readonly) NSDate *createdOn;

/*
 * The entity who created the notification
 */
@property (nonatomic, strong, readonly) PKTByLine *createdBy;

/*
 * Returns a list of notifications based on the query parameters. 
 * The notifications will be grouped based on their context.
 */
+ (PKTAsyncTask *)fetchNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKTAsyncTask *)fetchForNotificationsWithParameters:(PKTNotificationsRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
