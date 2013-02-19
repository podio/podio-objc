//
//  PKSpaceInviteData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2013-02-19.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKSpaceInviteData : PKObjectData

@property (nonatomic, copy) NSString *inviteCode;
@property (nonatomic, copy) NSString *message;

@end
