//
//  PKTUser.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTUser.h"
#import "PKTUsersAPI.h"
#import "PKTClient.h"

@implementation PKTUser

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"userID" : @"user_id",
           };
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchCurrentWithCompletion:(void (^)(PKTUser *user, NSError *error))completion {
  NSParameterAssert(completion);
  
  PKTRequest *request = [PKTUsersAPI requestForUserStatus];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [[requestTask taskByMappingResult:^id(PKTResponse *response) {
    PKTUser *user = nil;
    
    NSDictionary *userDict = [response.body objectForKey:@"user"];
    if (userDict) {
      user = [[self alloc] initWithDictionary:userDict];
    }
    
    return user;
  }] onSuccess:^(PKTUser *user) {
    if (completion) completion(user, nil);
  } onError:^(NSError *error) {
    if (completion) completion(nil, error);
  }];

  return task;
}

@end
