//
//  PKSearchAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/2/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKSearchAPI.h"

@interface PKSearchAPI ()

+ (PKRequest *)requestForSearchWithURI:(NSString *)uri query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end

@implementation PKSearchAPI

+ (PKRequest *)requestForSearchWithURI:(NSString *)uri query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
  
  request.offset = offset;
  request.body = [NSMutableDictionary dictionaryWithObject:query forKey:@"query"];
  
  if (offset > 0) {
    [request.body setObject:@(offset) forKey:@"offset"];
  }
  
  if (limit > 0) {
    [request.body setObject:@(limit) forKey:@"limit"];
  }
  
  return request;
}

+ (PKRequest *)requestForGlobalSearchWithQuery:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForSearchWithURI:@"/search/" query:query offset:offset limit:limit];
}

+ (PKRequest *)requestForSearchInOrganizationWithId:(NSUInteger)orgId query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForSearchWithURI:[NSString stringWithFormat:@"/search/org/%d", orgId] query:query offset:offset limit:limit];
}

+ (PKRequest *)requestForSearchInSpaceWithId:(NSUInteger)spaceId query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForSearchWithURI:[NSString stringWithFormat:@"/search/space/%d", spaceId] query:query offset:offset limit:limit];
}

+ (PKRequest *)requestForSearchInAppWithId:(NSUInteger)appId query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForSearchWithURI:[NSString stringWithFormat:@"/search/app/%d", appId] query:query offset:offset limit:limit];
}

@end
