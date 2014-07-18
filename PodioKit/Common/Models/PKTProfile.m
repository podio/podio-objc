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

#pragma mark - Private

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
