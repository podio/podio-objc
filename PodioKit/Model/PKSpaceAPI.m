//
//  PKSpaceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKSpaceAPI.h"

@implementation PKSpaceAPI

+ (PKRequest *)requestToJoinSpaceWithId:(NSUInteger)spaceId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%d/join", spaceId] method:PKAPIRequestMethodPOST];
}

+ (PKRequest *)requestToCreateSpaceWithName:(NSString *)name organizationId:(NSUInteger)organizationId {
  PKAssert(name != nil, @"Space name cannot be nil");
  PKAssert([name length] > 0, @"Space name cannot be empty");
  PKAssert(organizationId > 0, @"Invalid organization id %d", organizationId);
  
  PKRequest *request = [PKRequest requestWithURI:@"/space/" method:PKAPIRequestMethodPOST];
  
  request.body = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithUnsignedInteger:organizationId], @"org_id", name, @"name", nil];
  
  return request;
}

@end
