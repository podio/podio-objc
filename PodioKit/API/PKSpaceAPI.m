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

@end
