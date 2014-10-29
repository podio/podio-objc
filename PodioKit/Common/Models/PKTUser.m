//
//  PKTUser.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTUser.h"
#import "PKTUsersAPI.h"
#import "PKTPushCredential.h"
#import "PKTClient.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTUser

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"userID" : @"user_id",
           @"pushCredential" : @"push",
           };
}

+ (NSValueTransformer *)pushCredentialValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTPushCredential class]];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchCurrentUser {
  PKTRequest *request = [PKTUsersAPI requestForUserStatus];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    PKTUser *user = nil;
    
    NSDictionary *dict = [response.body objectForKey:@"user"];
    if (dict) {
      // Merge with "push"
      NSDictionary *pushDict = [response.body objectForKey:@"push"];
      if (pushDict) {
        NSMutableDictionary *mutDict = [dict mutableCopy];
        mutDict[@"push"] = pushDict;
        dict = [mutDict copy];
      }
      
      user = [[self alloc] initWithDictionary:dict];
    }
    
    return user;
  }];

  return task;
}

@end
