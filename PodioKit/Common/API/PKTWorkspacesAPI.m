//
//  PKTWorkspacesAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTWorkspacesAPI.h"

@implementation PKTWorkspacesAPI

+ (PKTRequest *)requestForWorkspaceWithID:(NSUInteger)workspaceID {
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/space/%lu", (unsigned long)workspaceID) parameters:nil];
}

+ (PKTRequest *)requestToCreateWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organizationID privacy:(PKTWorkspacePrivacy)privacy {
  NSParameterAssert(name);
  NSParameterAssert(organizationID > 0);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"name"] = name;
  params[@"org_id"] = @(organizationID);
  
  switch (privacy) {
    case PKTWorkspacePrivacyOpen:
      params[@"privacy"] = @"open";
      break;
    case PKTWorkspacePrivacyClosed:
      params[@"privacy"] = @"closed";
      break;
    default:
      break;
  }
  
  return [PKTRequest POSTRequestWithPath:@"/space/" parameters:params];
}

@end
