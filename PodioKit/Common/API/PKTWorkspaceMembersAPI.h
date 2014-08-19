//
//  PKTWorkspaceMembersAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 19/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTConstants.h"

@interface PKTWorkspaceMembersAPI : PKTBaseAPI

+ (PKTRequest *)requestToAddMembersToSpaceWithID:(NSUInteger)workspaceID role:(PKTWorkspaceMemberRole)role message:(NSString *)message userIDs:(NSArray *)userIDs profileIDs:(NSArray *)profileIDs emails:(NSArray *)emails;

@end
