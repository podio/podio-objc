//
//  PKTNotificationGroup.h
//  PodioKit
//
//  Created by Romain Briche on 19/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTNotificationContext;

@interface PKTNotificationGroup : PKTModel

/*
 * The context of the group of notifications
 */
@property (nonatomic, strong, readonly) PKTNotificationContext *context;

/*
 * The list of notifications for the given context
 */
@property (nonatomic, copy, readonly) NSArray *notifications;

@end
