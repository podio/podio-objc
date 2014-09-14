//
//  PKTNotificationsRequestParameters.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTRequestParameters.h"
#import "PKTConstants.h"

typedef NS_ENUM(NSUInteger, PKTNotificationDirection) {
  PKTNotificationDirectionDefault = 0,
  PKTNotificationDirectionIncoming,
  PKTNotificationDirectionOutgoing
};

typedef NS_ENUM(NSUInteger, PKTNotificationStarredState) {
  PKTNotificationStarredStateDefault = 0,
  PKTNotificationStarredStateStarred,
  PKTNotificationStarredStateUnstarred
};

typedef NS_ENUM(NSUInteger, PKTNotificationViewedState) {
  PKTNotificationViewedStateDefault = 0,
  PKTNotificationViewedStateNotViewed,
  PKTNotificationViewedStateViewed
};

typedef NS_ENUM(NSUInteger, PKTNotificationType) {
  PKTNotificationTypeNone = 0,
};

@interface PKTNotificationsRequestParameters : NSObject <PKTRequestParameters>

@property (nonatomic, assign) PKTReferenceType contextType;
@property (nonatomic, assign) PKTNotificationDirection direction;
@property (nonatomic, assign) PKTNotificationStarredState starred;
@property (nonatomic, assign) PKTNotificationViewedState viewed;
@property (nonatomic, assign) PKTNotificationType notificationType;
@property (nonatomic, assign) NSUInteger userID;
@property (nonatomic, copy) NSDate *createdFromDate;
@property (nonatomic, copy) NSDate *createdToDate;
@property (nonatomic, copy) NSDate *viewedFromDate;

@end
