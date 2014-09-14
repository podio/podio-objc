//
//  PKTAppsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppsAPI.h"

@implementation PKTAppsAPI

+ (PKTRequest *)requestForAppWithID:(NSUInteger)appID {
  NSParameterAssert(appID > 0);
  
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/app/%lu", (unsigned long)appID) parameters:nil];
}

+ (PKTRequest *)requestForAppsInWorkspaceWithID:(NSUInteger)spaceID {
  NSParameterAssert(spaceID > 0);
  
  NSString *path = PKTRequestPath(@"/app/space/%lu/", (unsigned long)spaceID);
  return [PKTRequest GETRequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestToAddAppToWorkspaceWithID:(NSUInteger)spaceID fields:(NSDictionary *)fields {
  NSParameterAssert(spaceID > 0);
  NSParameterAssert(fields);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"space_id"] = @(spaceID);
  params[@"fields"] = fields;
  
  return [PKTRequest POSTRequestWithPath:@"/app/" parameters:params];
}

@end
