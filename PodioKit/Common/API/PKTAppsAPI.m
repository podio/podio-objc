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
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/app/%lu", (unsigned long)appID) parameters:nil];
}

+ (PKTRequest *)requestForAppsInWorkspaceWithID:(NSUInteger)spaceID {
  NSString *path = PKTRequestPath(@"/app/space/%lu/", (unsigned long)spaceID);
  return [PKTRequest GETRequestWithPath:path parameters:nil];
}
@end
