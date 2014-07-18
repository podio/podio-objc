//
//  PKTProfile.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTProfile.h"
#import "PKTContactsAPI.h"

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
  return [self fetchProfileRequest:[PKTContactsAPI requestForContactWithProfileID:profileID] completion:completion];
}

+ (PKTRequestTaskHandle *)fetchProfileWithUserID:(NSUInteger)userID completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  return [self fetchProfileRequest:[PKTContactsAPI requestForContactWithUserID:userID] completion:completion];
}

#pragma mark - Private

+ (PKTRequestTaskHandle *)fetchProfileRequest:(PKTRequest *)request completion:(void (^)(PKTProfile *profile, NSError *error))completion {
  NSParameterAssert(completion);
  
  Class klass = [self class];
  
  PKTRequestTaskHandle *handle = [[PKTClient currentClient] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    PKTProfile *profile = nil;
    
    if (!error) {
      profile = [[klass alloc] initWithDictionary:response.body];
    }
    
    completion(profile, error);
  }];
  
  return handle;
}

@end
