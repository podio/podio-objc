//
//  PKTUsersAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 17/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTUsersAPI : PKTBaseAPI

+ (PKTRequest *)requestForUserStatus;

@end
