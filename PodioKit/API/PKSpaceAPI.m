//
//  PKSpaceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKSpaceAPI.h"

@implementation PKSpaceAPI

+ (PKRequest *)requestToJoinSpaceWithId:(NSUInteger)spaceId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%d/join", spaceId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToAcceptSpaceMemberRequestWithId:(NSUInteger)requestId spaceId:(NSUInteger)spaceId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%d/member_request/%d", spaceId, requestId] method:PKRequestMethodPUT];
}

+ (PKRequest *)requestToCreateSpaceWithName:(NSString *)name organizationId:(NSUInteger)organizationId {
  PKAssert(name != nil, @"Space name cannot be nil");
  PKAssert([name length] > 0, @"Space name cannot be empty");
  PKAssert(organizationId > 0, @"Invalid organization id %d", organizationId);
  
  PKRequest *request = [PKRequest requestWithURI:@"/space/" method:PKRequestMethodPOST];
  
  request.body = @{@"org_id": @(organizationId), @"name": name};
  
  return request;
}

+ (PKRequest *)requestToAddMemberToSpaceWithId:(NSUInteger)spaceId role:(PKRole)role userIds:(NSArray *)userIds emails:(NSArray *)emails externalContacts:(NSDictionary *)externalContacts {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%d/member/", spaceId] method:PKRequestMethodPOST];
  
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

@end
