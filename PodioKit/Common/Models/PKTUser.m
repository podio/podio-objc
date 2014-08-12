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

+ (PKTAsyncTask *)fetchCurrent {
  PKTRequest *request = [PKTUsersAPI requestForUserStatus];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    PKTUser *user = nil;
    
    NSDictionary *userDict = [response.body objectForKey:@"user"];
    if (userDict) {
      user = [[self alloc] initWithDictionary:userDict];
    }
    
    return user;
  }];

  return task;
}

@end
