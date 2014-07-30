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

+ (PKTAsyncTask *)fetchProfileWithID:(NSUInteger)profileID completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  return [self fetchProfileWithRequest:[PKTContactsAPI requestForContactWithProfileID:profileID] completion:completion];
}

+ (PKTAsyncTask *)fetchProfileWithUserID:(NSUInteger)userID completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  return [self fetchProfileWithRequest:[PKTContactsAPI requestForContactWithUserID:userID] completion:completion];
}

+ (PKTAsyncTask *)fetchProfilesWithIDs:(NSArray *)profileIDs completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithRequest:[PKTContactsAPI requestForContactsWithProfileIDs:profileIDs] completion:completion];
}

+ (PKTAsyncTask *)fetchContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithContactType:PKTContactTypeUser | PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTAsyncTask *)fetchUsersWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithContactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTAsyncTask *)fetchWorkspaceContactsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesWithContactType:PKTContactTypeSpace
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTAsyncTask *)fetchContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingName:name
                               contactType:PKTContactTypeUser | PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTAsyncTask *)fetchUsersByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingName:name contactType:PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingName:(NSString *)name offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingName:name contactType:PKTContactTypeSpace
                                    offset:offset
                                     limit:limit
                                completion:completion];
}

+ (PKTAsyncTask *)fetchContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeUser | PKTContactTypeSpace
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTAsyncTask *)fetchUsersByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTAsyncTask *)fetchWorkspaceContactsByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  return [self fetchProfilesByMatchingField:fieldName
                                      value:fieldValue
                                contactType:PKTContactTypeSpace
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

#pragma mark - Private

+ (PKTAsyncTask *)fetchProfilesWithContactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  PKTRequest *request = [PKTContactsAPI requestForContactsOfType:contactType
                                                     excludeSelf:NO
                                                        ordering:PKTContactsOrderingDefault
                                                          fields:nil
                                                  requiredFields:nil
                                                          offset:offset
                                                           limit:limit];
  
  return [self fetchProfilesWithRequest:request completion:completion];
}

+ (PKTAsyncTask *)fetchProfilesByMatchingName:(NSString *)name contactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
  NSParameterAssert(name);
  
  return [self fetchProfilesByMatchingField:@"name"
                                      value:name
                                contactType:PKTContactTypeUser
                                     offset:offset
                                      limit:limit
                                 completion:completion];
}

+ (PKTAsyncTask *)fetchProfilesByMatchingField:(NSString *)fieldName value:(NSString *)fieldValue contactType:(PKTContactType)contactType offset:(NSUInteger)offset limit:(NSUInteger)limit completion:(void (^)(NSArray *profiles, NSError *error))completion {
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

+ (PKTAsyncTask *)fetchProfileWithRequest:(PKTRequest *)request completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];

  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }] onSuccess:^(PKTProfile *profile) {
    completion(profile, nil);
  } onError:^(NSError *error) {
    completion(nil, error);;
  }];
  
  return task;
}

+ (PKTAsyncTask *)fetchProfilesWithRequest:(PKTRequest *)request completion:(void (^)(NSArray *profiles, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    NSArray *profileDicts = ![response.body isKindOfClass:[NSArray class]] ? @[response.body] : response.body;
    
    NSArray *profiles = [profileDicts pkt_mappedArrayWithBlock:^id(NSDictionary *profileDict) {
      return [[self alloc] initWithDictionary:profileDict];
    }];

    return profiles;
  }] onSuccess:^(NSArray *profiles) {
    completion(profiles, nil);
  } onError:^(NSError *error) {
    completion(nil, error);;
  }];
  
  return task;
}

@end
