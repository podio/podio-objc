//
//  PKAppAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/15/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKAppAPI.h"

@implementation PKAppAPI

+ (PKRequest *)requestForAppWithId:(NSUInteger)appId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/app/%d", appId] method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestToInstallAppWithId:(NSUInteger)appId spaceId:(NSUInteger)spaceId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/app/%d/install", appId] method:PKAPIRequestMethodPOST];
  
  request.body = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:spaceId] forKey:@"space_id"];
  
  return request;
}

+ (PKRequest *)requestForAppsInSpaceWithId:(NSUInteger)spaceId {
  NSString *uri = [NSString stringWithFormat:@"/app/space/%d/", spaceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
  
  return request;
}

@end
