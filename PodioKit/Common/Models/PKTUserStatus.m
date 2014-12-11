//
//  PKTUserStatus.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/12/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTUserStatus.h"
#import "PKTUser.h"
#import "PKTProfile.h"
#import "PKTPushCredential.h"
#import "PKTUsersAPI.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTUserStatus

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"newNotificationsCount": @"inbox_new",
    @"unreadMessagesCount": @"message_unread_count",
    @"calendarCode": @"calendar_code",
    @"pushCredential": @"push",
  };
}

+ (NSValueTransformer *)userValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTUser class]];
}

+ (NSValueTransformer *)profileValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTProfile class]];
}

+ (NSValueTransformer *)pushCredentialValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTPushCredential class]];
}

+ (NSValueTransformer *)unreadMessagesCountValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(id value) {
    return value;
  }];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchStatusForCurrentUser {
  PKTRequest *request = [PKTUsersAPI requestForUserStatus];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  return [requestTask map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];
}

@end
