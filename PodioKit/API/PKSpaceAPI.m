//
//  PKSpaceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKSpaceAPI.h"

@implementation PKSpaceAPI

+ (PKRequest *)requestForSpaceWithId:(NSUInteger)spaceId {
  return [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/space/%ld", (unsigned long)spaceId]];
}

+ (PKRequest *)requestToJoinSpaceWithId:(NSUInteger)spaceId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%ld/join", (unsigned long)spaceId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToAcceptSpaceMemberRequestWithId:(NSUInteger)requestId spaceId:(NSUInteger)spaceId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%ld/member_request/%ld/accept", (unsigned long)spaceId, (unsigned long)requestId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToCreateSpaceWithName:(NSString *)name organizationId:(NSUInteger)organizationId {
  PKAssert(name != nil, @"Space name cannot be nil");
  PKAssert([name length] > 0, @"Space name cannot be empty");
  PKAssert(organizationId > 0, @"Invalid organization id %ld", (unsigned long)organizationId);
  
  PKRequest *request = [PKRequest requestWithURI:@"/space/" method:PKRequestMethodPOST];
  
  request.body = @{@"org_id": @(organizationId), @"name": name};
  
  return request;
}

+ (PKRequest *)requestToAddMemberToSpaceWithId:(NSUInteger)spaceId role:(PKRole)role userIds:(NSArray *)userIds emails:(NSArray *)emails externalContacts:(NSDictionary *)externalContacts {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%ld/member/", (unsigned long)spaceId] method:PKRequestMethodPOST];
  
  request.body = [NSMutableDictionary dictionary];
  request.body[@"role"] = [PKConstants stringForRole:role];
  
  if ([userIds count] > 0) {
    request.body[@"users"] = userIds;
  }
  
  if ([emails count] > 0) {
    request.body[@"mails"] = emails;
  }
  
  if ([externalContacts count] > 0) {
    request.body[@"external_contacts"] = externalContacts;
  }
  
  return request;
}

+ (PKRequest *)requestToRemoveMemberWithUserId:(NSUInteger)userId fromSpaceWithId:(NSUInteger)spaceId {
  return [PKRequest deleteRequestWithURI:[NSString stringWithFormat:@"/space/%ld/member/%ld", (unsigned long)spaceId, (unsigned long)userId]];
}

@end
