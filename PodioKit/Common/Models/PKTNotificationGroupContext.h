//
//  PKTNotificationGroupContext.h
//  PodioKit
//
//  Created by Romain Briche on 20/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@class PKTReference, PKTWorkspace, PKTOrganization;

@interface PKTNotificationGroupContext : PKTModel

/*
 * The reference of the context
 */
@property (nonatomic, strong, readonly) PKTReference *reference;

/*
 * The data of the context, depends on the type of reference
 */
@property (nonatomic, strong, readonly) id data;

/*
 * The title of the context
 */
@property (nonatomic, copy, readonly) NSString *title;

/*
 * The list of rights the active user has on the context
 */
@property (nonatomic, assign, readonly) PKTRight rights;

/*
 * The number of comments on the objects (only for objects of type status, task and item)
 */
@property (nonatomic, assign, readonly) NSUInteger commentCount;

/*
 * The space the context belongs to, if any
 */
@property (nonatomic, strong, readonly) PKTWorkspace *space;

/*
 * The organization the context belongs to, if any
 */
@property (nonatomic, strong, readonly) PKTOrganization *org;

/*
 * The link of the context
 */
@property (nonatomic, copy, readonly) NSURL *link;

@end
