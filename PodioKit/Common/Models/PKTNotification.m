//
//  PKTNotification.m
//  PodioKit
//
//  Created by Romain Briche on 19/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotification.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTByLine.h"
#import "PKTNotificationsAPI.h"
#import "PKTClient.h"
#import "NSArray+PKTAdditions.h"
#import "PKTNotificationGroup.h"

@implementation PKTNotification

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"notificationID": @"notification_id",
    @"notificationType": @"type",
    @"textShort": @"text_short",
    @"viewedOn": @"viewed_on",
    @"subscriptionID": @"subscription_id",
    @"createdOn": @"created_on",
    @"createdBy": @"created_by",
  };
}

#pragma mark - Properties

- (BOOL)viewed {
  return self.viewedOn != nil;
}

+ (NSSet *)keyPathsForValuesAffectingViewed {
  return [NSSet setWithObject:@"viewedOn"];
}

#pragma mark - Value transformers

+ (NSValueTransformer *)notificationTypeValueTransformer {
  return [NSValueTransformer pkt_notificationTypeTransformer];
}

+ (NSValueTransformer *)viewedOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)createdByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

#pragma mark - API calls

+ (PKTAsyncTask *)fetchNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self fetchForNotificationsWithParameters:nil offset:offset limit:limit];
}

+ (PKTAsyncTask *)fetchForNotificationsWithParameters:(PKTNotificationsRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTNotificationsAPI requestForNotificationsWithParameters:parameters offset:offset limit:limit];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
      return [[PKTNotificationGroup alloc] initWithDictionary:dict];
    }];
  }];
  
  return task;
}

+ (PKTAsyncTask *)markNotificationsAsViewedWithReferenceID:(NSUInteger)refenceID type:(PKTReferenceType)referenceType {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationsAsViewedWithReferenceID:refenceID type:referenceType];
  
  return [[PKTClient currentClient] performRequest:request];
}

+ (PKTAsyncTask *)markNotificationsAsUnviewedWithReferenceID:(NSUInteger)refenceID type:(PKTReferenceType)referenceType {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationsAsUnviewedWithReferenceID:refenceID type:referenceType];
  
  return [[PKTClient currentClient] performRequest:request];
}

- (PKTAsyncTask *)markAsViewed {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationAsViewedWithID:self.notificationID];
  
  return [[PKTClient currentClient] performRequest:request];
}

- (PKTAsyncTask *)markAsUnviewed {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationAsUnviewedWithID:self.notificationID];
  
  return [[PKTClient currentClient] performRequest:request];
}

- (PKTAsyncTask *)star {
  PKTRequest *request = [PKTNotificationsAPI requestToStarNotificationWithID:self.notificationID];
  
  return [[PKTClient currentClient] performRequest:request];
}

- (PKTAsyncTask *)unstar {
  {
    PKTRequest *request = [PKTNotificationsAPI requestToUnstarNotificationWithID:self.notificationID];
    
    return [[PKTClient currentClient] performRequest:request];
  }
}

@end
