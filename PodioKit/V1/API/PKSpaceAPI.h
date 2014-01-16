//
//  PKSpaceAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKSpaceAPI : PKBaseAPI

+ (PKRequest *)requestForSpaceWithId:(NSUInteger)spaceId;

+ (PKRequest *)requestToJoinSpaceWithId:(NSUInteger)spaceId;
+ (PKRequest *)requestToAcceptSpaceMemberRequestWithId:(NSUInteger)requestId spaceId:(NSUInteger)spaceId;
+ (PKRequest *)requestToCreateSpaceWithName:(NSString *)name organizationId:(NSUInteger)organizationId;

+ (PKRequest *)requestToAddMemberToSpaceWithId:(NSUInteger)spaceId role:(PKRole)role userIds:(NSArray *)userIds emails:(NSArray *)emails externalContacts:(NSDictionary *)externalContacts;

+ (PKRequest *)requestToRemoveMemberWithUserId:(NSUInteger)userId fromSpaceWithId:(NSUInteger)spaceId;

@end
