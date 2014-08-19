//
//  PKTWorkspaceMembersAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 19/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTWorkspaceMembersAPI.h"

@implementation PKTWorkspaceMembersAPI

+ (PKTRequest *)requestToAddMembersToSpaceWithID:(NSUInteger)workspaceID role:(PKTWorkspaceMemberRole)role message:(NSString *)message userIDs:(NSArray *)userIDs profileIDs:(NSArray *)profileIDs emails:(NSArray *)emails {
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  if (message) {
    params[@"message"] = message;
  }
  
  switch (role) {
    case PKTWorkspaceMemberRoleAdmin:
      params[@"role"] = @"admin";
      break;
    case PKTWorkspaceMemberRoleRegular:
      params[@"role"] = @"regular";
      break;
    case PKTWorkspaceMemberRoleLight:
      params[@"role"] = @"light";
      break;
    default:
      break;
  }
  
  if ([userIDs count] > 0) {
    params[@"users"] = userIDs;
  }
  
  if ([profileIDs count] > 0) {
    params[@"profiles"] = profileIDs;
  }
  
  if ([emails count] > 0) {
    params[@"mails"] = emails;
  }
  
  return [PKTRequest POSTRequestWithPath:PKTRequestPath(@"/space/%lu/member/", (unsigned long)workspaceID) parameters:params];
}

@end
