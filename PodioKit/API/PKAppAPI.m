//
//  PKAppAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/15/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAppAPI.h"

@implementation PKAppAPI

+ (PKRequest *)requestForAppWithId:(NSUInteger)appId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/app/%ld", (unsigned long)appId] method:PKRequestMethodGET];
}

+ (PKRequest *)requestToInstallAppWithId:(NSUInteger)appId spaceId:(NSUInteger)spaceId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/app/%ld/install", (unsigned long)appId] method:PKRequestMethodPOST];
  
  request.body = @{@"space_id": @(spaceId)};
  
  return request;
}

+ (PKRequest *)requestForAppsInSpaceWithId:(NSUInteger)spaceId {
  NSString *uri = [NSString stringWithFormat:@"/app/space/%ld/", (unsigned long)spaceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET];
  
  return request;
}

+ (PKRequest *)requestForTopAppsWithLimit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:@"/app/top/" method:PKRequestMethodGET];
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)limit] forKey:@"limit"];
  }

  return request;
}

+ (PKRequest *)requestToDeleteAppWithId:(NSUInteger)appId {
  NSString *uri = [NSString stringWithFormat:@"/app/%ld/", (unsigned long)appId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodDELETE];

  return request;
}

@end
