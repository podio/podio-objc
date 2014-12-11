//
//  PKTUser.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTUser.h"
#import "PKTUserStatus.h"
#import "PKTAsyncTask.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTUser

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"userID" : @"user_id"
           };
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchCurrentUser {
  return [[PKTUserStatus fetchStatusForCurrentUser] map:^id(PKTUserStatus *status) {
    return status.user;
  }];
}

@end
