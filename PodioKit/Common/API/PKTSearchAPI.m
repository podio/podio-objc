//
//  PKTSearchAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTSearchAPI.h"

@implementation PKTSearchAPI

#pragma mark - Public

+ (PKTRequest *)requestToSearchGloballyWithQuery:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestToSearchWithPath:@"/search/v2" query:query offset:offset limit:limit];
}

+ (PKTRequest *)requestToSearchInOrganizationWithID:(NSUInteger)organizationID query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(organizationID > 0);
  
  NSString *path = PKTRequestPath(@"/search/org/%lu/v2", (unsigned long)organizationID);
  PKTRequest *request = [self requestToSearchWithPath:path query:query offset:offset limit:limit];
  
  return request;
}

+ (PKTRequest *)requestToSearchInWorkspaceWithID:(NSUInteger)workspaceID Query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(workspaceID > 0);
  
  NSString *path = PKTRequestPath(@"/search/space/%lu/v2", (unsigned long)workspaceID);
  PKTRequest *request = [self requestToSearchWithPath:path query:query offset:offset limit:limit];
  
  return request;
}

+ (PKTRequest *)requestToSearchInAppWithID:(NSUInteger)appID query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(appID > 0);
  
  NSString *path = PKTRequestPath(@"/search/app/%lu/v2", (unsigned long)appID);
  PKTRequest *request = [self requestToSearchWithPath:path query:query offset:offset limit:limit];
  
  return request;
}

#pragma mark - Private

+ (PKTRequest *)requestToSearchWithPath:(NSString *)path query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:[query queryParameters]];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:path parameters:params];
}

@end
