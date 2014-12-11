//
//  PKTUserStatus.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/12/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTUser, PKTProfile, PKTPushCredential, PKTAsyncTask;

@interface PKTUserStatus : PKTModel

@property (nonatomic, readonly) NSUInteger newNotificationsCount;
@property (nonatomic, readonly) NSUInteger unreadMessagesCount;
@property (nonatomic, copy, readonly) PKTUser *user;
@property (nonatomic, copy, readonly) PKTUser *profile;
@property (nonatomic, copy, readonly) PKTPushCredential *pushCredential;
@property (nonatomic, copy, readonly) NSArray *betas;
@property (nonatomic, copy, readonly) NSArray *flags;
@property (nonatomic, copy, readonly) NSString *calendarCode;
@property (nonatomic, copy, readonly) NSString *mailbox;

+ (PKTAsyncTask *)fetchStatusForCurrentUser;

@end
