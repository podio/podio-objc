//
//  PKTProfile.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTProfile.h"
#import "PKTContactsAPI.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTProfile

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"profileID" : @"profile_id",
           @"userID" : @"user_id"
           };
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchProfileWithID:(NSUInteger)profileID {
  return [self fetchProfileWithRequest:[PKTContactsAPI requestForContactWithProfileID:profileID]];
}

+ (PKTAsyncTask *)fetchProfileWithUserID:(NSUInteger)userID {
  return [self fetchProfileWithRequest:[PKTContactsAPI requestForContactWithUserID:userID]];
}

+ (PKTAsyncTask *)fetchProfilesWithIDs:(NSArray *)profileIDs {
  return [self fetchProfilesWithRequest:[PKTContactsAPI requestForContactsWithProfileIDs:profileIDs]];
}

+ (PKTAsyncTask *)fetchContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesWithContactType:PKTContactTypeUser | PKTContactTypeSpace
                                    offset:offset
                                     limit:limit];
}

+ (PKTAsyncTask *)fetchUsersWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesWithContactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit];
}

+ (PKTAsyncTask *)fetchWorkspaceContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesWithContactType:PKTContactTypeSpace
                                     offset:offset
                                      limit:limit];
}

+ (PKTAsyncTask *)fetchContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesByMatchingName:name
                               contactType:PKTContactTypeUser | PKTContactTypeSpace
                                    offset:offset
                                     limit:limit];
}

+ (PKTAsyncTask *)fetchUsersByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesByMatchingName:name contactType:PKTContactTypeSpace
                                    offset:offset
                                     limit:limit];
}

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesByMatchingName:name contactType:PKTContactTypeSpace
                                    offset:offset
                                     limit:limit];
}

+ (PKTAsyncTask *)fetchContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeUser | PKTContactTypeSpace
                                     offset:offset
                                      limit:limit];
}

+ (PKTAsyncTask *)fetchUsersByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit];
}

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeSpace
                                     offset:offset
                                      limit:limit];
}

#pragma mark - Private

+ (PKTAsyncTask *)fetchProfilesWithContactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTContactsAPI requestForContactsOfType:contactType
                                                     excludeSelf:NO
                                                        ordering:PKTContactsOrderingDefault
                                                          fields:nil
                                                  requiredFields:nil
                                                          offset:offset
                                                           limit:limit];
  
  return [self fetchProfilesWithRequest:request];
}

+ (PKTAsyncTask *)fetchProfilesByMatchingName:(NSString *)name contactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(name);
  
  return [self fetchProfilesByMatchingField:@"name"
                                      value:name
                                contactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit];
}

+ (PKTAsyncTask *)fetchProfilesByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue contactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(fieldName);
  NSParameterAssert(fieldValue);
  
  PKTRequest *request = [PKTContactsAPI requestForContactsOfType:contactType
                                                     excludeSelf:NO
                                                        ordering:PKTContactsOrderingDefault
                                                          fields:nil
                                                  requiredFields:nil
                                                          offset:offset
                                                           limit:limit];
  
  return [self fetchProfilesWithRequest:request];
}

+ (PKTAsyncTask *)fetchProfileWithRequest:(PKTRequest *)request {
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];

  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];
  
  return task;
}

+ (PKTAsyncTask *)fetchProfilesWithRequest:(PKTRequest *)request {
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    NSArray *profileDicts = ![response.body isKindOfClass:[NSArray class]] ? @[response.body] : response.body;
    
    NSArray *profiles = [profileDicts pkt_mappedArrayWithBlock:^id(NSDictionary *profileDict) {
      return [[self alloc] initWithDictionary:profileDict];
    }];

    return profiles;
  }];
  
  return task;
}

@end
