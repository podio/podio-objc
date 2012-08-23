//
//  PKContactAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/9/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKContactAPI.h"

@interface PKContactAPI ()

+ (PKRequest *)requestForContactsWithURI:(NSString *)uri type:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end

@implementation PKContactAPI

+ (PKRequest *)requestForContactsWithURI:(NSString *)uri type:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
  
  request.offset = offset;
  [request.parameters setObject:[NSString stringWithFormat:@"%d", excludeSelf] forKey:@"exclude_self"];
  
  switch (type) {
    case PKRequestContactTypeFull:
      [request.parameters setObject:@"full" forKey:@"type"];
      break;
    case PKRequestContactTypeMini:
      [request.parameters setObject:@"mini" forKey:@"type"];
      break;
    default:
      break;
  }
  
  if (contactTypes != nil) {
    [request.parameters setObject:[contactTypes componentsJoinedByString:@","] forKey:@"contact_type"];
  }
  
  if (offset > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
  }
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", limit] forKey:@"limit"];
  }
  
  return request;
}

+ (PKRequest *)requestForGlobalContactsWithType:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForContactsWithURI:@"/contact/" type:type contactTypes:contactTypes excludeSelf:excludeSelf offset:offset limit:limit];
}

+ (PKRequest *)requestForContactsInSpaceWithId:(NSUInteger)spaceId type:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSString *uri = [NSString stringWithFormat:@"/contact/space/%d/", spaceId];
  return [self requestForContactsWithURI:uri type:type contactTypes:contactTypes excludeSelf:excludeSelf offset:offset limit:limit];
}

+ (PKRequest *)requestForContactsInOrganizationWithId:(NSUInteger)orgId type:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSString *uri = [NSString stringWithFormat:@"/contact/org/%d/", orgId];
  return [self requestForContactsWithURI:uri type:type contactTypes:contactTypes excludeSelf:excludeSelf offset:offset limit:limit];
}

+ (PKRequest *)requestForContactWithProfileId:(NSUInteger)profileId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/contact/%d/v2", profileId] method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestForContactWithUserId:(NSUInteger)userId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/contact/user/%d", userId] method:PKAPIRequestMethodGET];
}

@end
