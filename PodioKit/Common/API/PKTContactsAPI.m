//
//  PKTContactsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTContactsAPI.h"

@implementation PKTContactsAPI

#pragma mark - Public

+ (PKTRequest *)requestForContactWithUserID:(NSUInteger)userID {
  PKTRequest *request = [PKTRequest GETRequestWithPath:PKTRequestPath(@"/contact/user/%lu", (unsigned long)userID) parameters:nil];
  
  return request;
}

+ (PKTRequest *)requestForContactWithProfileID:(NSUInteger)profileID {
  return [self requestForContactsWithProfileIDs:@[@(profileID)]];
}

+ (PKTRequest *)requestForContactsWithProfileIDs:(NSArray *)profileIDs {
  NSString *profileIDsString = [profileIDs componentsJoinedByString:@","];
  PKTRequest *request = [PKTRequest GETRequestWithPath:PKTRequestPath(@"/contact/%@/v2", profileIDsString) parameters:nil];
  
  return request;
}

+ (PKTRequest *)requestForContactsInWorkspaceWithID:(NSUInteger)workspaceID contactType:(PKTContactType)contactType excludeSelf:(BOOL)excludeSelf ordering:(PKTContactsOrdering)ordering fields:(NSDictionary *)fields requiredFields:(NSArray *)requiredFields offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForContactsWithPath:PKTRequestPath(@"/contact/space/%lu/", (unsigned long)workspaceID)
                              contactType:contactType
                              excludeSelf:excludeSelf
                                 ordering:ordering
                                   fields:fields
                           requiredFields:requiredFields
                                   offset:offset
                                    limit:limit];
}

+ (PKTRequest *)requestForContactsOfType:(PKTContactType)contactType excludeSelf:(BOOL)excludeSelf ordering:(PKTContactsOrdering)ordering fields:(NSDictionary *)fields requiredFields:(NSArray *)requiredFields offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForContactsWithPath:@"/contact/"
                              contactType:contactType
                              excludeSelf:excludeSelf
                                 ordering:ordering
                                   fields:fields
                           requiredFields:requiredFields
                                   offset:offset
                                    limit:limit];
}

#pragma mark - Private

+ (PKTRequest *)requestForContactsWithPath:(NSString *)path contactType:(PKTContactType)contactType excludeSelf:(BOOL)excludeSelf ordering:(PKTContactsOrdering)ordering fields:(NSDictionary *)fields requiredFields:(NSArray *)requiredFields offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  params[@"exclude_self"] = @(excludeSelf);
  params[@"type"] = @"full";
  
  if ([fields count] > 0) [params addEntriesFromDictionary:fields];
  if (offset > 0) params[@"offset"] = @(offset);
  if (limit > 0) params[@"limit"] = @(limit);
  if ([requiredFields count] > 0) params[@"required"] = [requiredFields componentsJoinedByString:@","];
  
  NSString *contactTypes = [self stringForContactType:contactType];
  if ([contactTypes length] > 0) params[@"contact_type"] = contactTypes;
  
  if (ordering != PKTContactsOrderingDefault) params[@"order"] = [self stringForOrdering:ordering];
  
  return [PKTRequest GETRequestWithPath:path parameters:params];
}

+ (NSString *)stringForContactType:(PKTContactType)contactType {
  NSMutableArray *types = [NSMutableArray new];
  
  if ((contactType & PKTContactTypeUser) != 0) [types addObject:@"user"];
  if ((contactType & PKTContactTypeSpace) != 0) [types addObject:@"space"];
  
  return [types componentsJoinedByString:@","];
}

+ (NSString *)stringForOrdering:(PKTContactsOrdering)ordering {
  NSString *string = nil;
  
  switch (ordering) {
      case PKTContactsOrderingAssign:
      string = @"assign";
      break;
    case PKTContactsOrderingAlert:
      string = @"alert";
      break;
    case PKTContactsOrderingMessage:
      string = @"message";
      break;
    case PKTContactsOrderingReference:
      string = @"reference";
      break;
    case PKTContactsOrderingOverall:
      string = @"overall";
      break;
      default:
      break;
  }
  
  return string;
}

@end
