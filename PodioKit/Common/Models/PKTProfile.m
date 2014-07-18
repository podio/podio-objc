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

+ (PKTRequestTaskHandle *)fetchProfileWithID:(NSUInteger)profileID completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  return [self fetchProfileWithRequest:[PKTContactsAPI requestForContactWithProfileID:profileID] completion:completion];
}

+ (PKTRequestTaskHandle *)fetchProfileWithUserID:(NSUInteger)userID completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  return [self fetchProfileWithRequest:[PKTContactsAPI requestForContactWithUserID:userID] completion:completion];
}

+ (PKTRequestTaskHandle *)fetchProfilesWithIDs:(NSArray *)profileIDs completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithRequest:[PKTContactsAPI requestForContactsWithProfileIDs:profileIDs] completion:completion];
}

+ (PKTRequestTaskHandle *)fetchContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithContactType:PKTContactTypeUser | PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTRequestTaskHandle *)fetchUsersWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithContactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTRequestTaskHandle *)fetchWorkspaceContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithContactType:PKTContactTypeSpace
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTRequestTaskHandle *)fetchContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingName:name
                               contactType:PKTContactTypeUser | PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTRequestTaskHandle *)fetchUsersByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingName:name contactType:PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTRequestTaskHandle *)fetchWorkspaceContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingName:name contactType:PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTRequestTaskHandle *)fetchContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeUser | PKTContactTypeSpace
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTRequestTaskHandle *)fetchUsersByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTRequestTaskHandle *)fetchWorkspaceContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeSpace
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

#pragma mark - Private

+ (PKTRequestTaskHandle *)fetchProfilesWithContactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  PKTRequest *request = [PKTContactsAPI requestForContactsOfType:contactType
                                                     excludeSelf:NO
                                                        ordering:PKTContactsOrderingDefault
                                                          fields:nil
                                                  requiredFields:nil
                                                          offset:offset
                                                           limit:limit];
  
  return [self fetchProfilesWithRequest:request completion:completion];
}

+ (PKTRequestTaskHandle *)fetchProfilesByMatchingName:(NSString *)name contactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  NSParameterAssert(name);
  
  return [self fetchProfilesByMatchingField:@"name"
                                      value:name
                                contactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTRequestTaskHandle *)fetchProfilesByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue contactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  NSParameterAssert(fieldName);
  NSParameterAssert(fieldValue);
  
  PKTRequest *request = [PKTContactsAPI requestForContactsOfType:contactType
                                                     excludeSelf:NO
                                                        ordering:PKTContactsOrderingDefault
                                                          fields:nil
                                                  requiredFields:nil
                                                          offset:offset
                                                           limit:limit];
  
  return [self fetchProfilesWithRequest:request completion:completion];
}

+ (PKTRequestTaskHandle *)fetchProfileWithRequest:(PKTRequest *)request completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTProfile *profile = nil;
    
    if (!error) {
      profile = [[self alloc] initWithDictionary:response.body];
    }
    
    completion(profile, error);
  }];
  
  return handle;
}

+ (PKTRequestTaskHandle *)fetchProfilesWithRequest:(PKTRequest *)request completion:(void (^)(NSArray *profiles, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    NSArray *profiles = nil;
    
    if (!error) {
      profiles = [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *profileDict) {
        return [[self alloc] initWithDictionary:profileDict];
      }];
    }
    
    completion(profiles, error);
  }];
  
  return handle;
}

@end
