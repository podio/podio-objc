//
//  PKTNotificationsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationsAPI.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTNotificationsAPI

+ (PKTRequest *)requestForNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForNotificationsWithParameters:nil offset:offset limit:limit];
}

+ (PKTRequest *)requestForNotificationsWithParameters:(PKTNotificationsRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameters.queryParameters];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:@"/notification/" parameters:params];
}

+ (PKTRequest *)requestToMarkNotificationsAsViewedWithReferenceID:(NSUInteger)referenceID type:(PKTReferenceType)referenceType {
  NSParameterAssert(referenceID > 0);
  NSParameterAssert(referenceType != PKTReferenceTypeUnknown);
  
  NSString *referenceTypeString = [NSValueTransformer pkt_stringFromReferenceType:referenceType];
  NSString *path = PKTRequestPath(@"/notification/%@/%lu/viewed", referenceTypeString, (unsigned long)referenceID);
  
  return [PKTRequest POSTRequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestToMarkNotificationsAsUnviewedWithReferenceID:(NSUInteger)referenceID type:(PKTReferenceType)referenceType {
  NSParameterAssert(referenceID > 0);
  NSParameterAssert(referenceType != PKTReferenceTypeUnknown);
  
  NSString *referenceTypeString = [NSValueTransformer pkt_stringFromReferenceType:referenceType];
  NSString *path = PKTRequestPath(@"/notification/%@/%lu/viewed", referenceTypeString, (unsigned long)referenceID);
  
  return [PKTRequest DELETERequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestToMarkNotificationAsViewedWithID:(NSUInteger)notificationID {
  NSParameterAssert(notificationID > 0);
  NSString *path = PKTRequestPath(@"/notification/%lu/viewed", (unsigned long)notificationID);
  
  return [PKTRequest POSTRequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestToMarkNotificationAsUnviewedWithID:(NSUInteger)notificationID {
  NSParameterAssert(notificationID > 0);
  NSString *path = PKTRequestPath(@"/notification/%lu/viewed", (unsigned long)notificationID);
  
  return [PKTRequest DELETERequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestToStarNotificationWithID:(NSUInteger)notificationID {
  NSParameterAssert(notificationID > 0);
  NSString *path = PKTRequestPath(@"/notification/%lu/star", (unsigned long)notificationID);
  
  return [PKTRequest POSTRequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestToUnstarNotificationWithID:(NSUInteger)notificationID {
  NSParameterAssert(notificationID > 0);
  NSString *path = PKTRequestPath(@"/notification/%lu/star", (unsigned long)notificationID);
  
  return [PKTRequest DELETERequestWithPath:path parameters:nil];
}

@end
