//
//  PKNotificationsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/11/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKNotificationAPI.h"
#import "NSDate+PKAdditions.h"

@implementation PKNotificationAPI

+ (PKRequest *)requestForNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo options:(NSDictionary *)options {
  PKRequest *request = [PKRequest requestWithURI:@"/notification/" method:PKRequestMethodGET];
  request.parameters = [NSMutableDictionary dictionaryWithDictionary:options];
  
  request.offset = offset;
  [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)offset] forKey:@"offset"];
  [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)limit] forKey:@"limit"];
  
  if (dateFrom != nil) {
    [request.parameters setObject:[[dateFrom pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"created_from"];
  }
  
  if (dateTo != nil) {
    [request.parameters setObject:[[dateTo pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"created_to"];
  }
  
  return request;
}

+ (PKRequest *)requestForNewNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo {
  NSDictionary *options = @{@"viewed": @"0",
                           @"direction": @"incoming"};
  return [self requestForNotificationsWithOffset:offset limit:limit dateFrom:dateFrom dateTo:dateTo options:options];
}

+ (PKRequest *)requestForViewedNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo {
  NSDictionary *options = @{@"viewed": @"1",
                           @"direction": @"incoming"};
  return [self requestForNotificationsWithOffset:offset limit:limit dateFrom:dateFrom dateTo:dateTo options:options];
}

+ (PKRequest *)requestForStarredNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo {
  NSDictionary *options = @{@"starred": @"1"};
  return [self requestForNotificationsWithOffset:offset limit:limit dateFrom:dateFrom dateTo:dateTo options:options];
}

+ (PKRequest *)requestForSentNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit dateFrom:(NSDate *)dateFrom dateTo:(NSDate *)dateTo {
  NSDictionary *options = @{@"context_type": @"conversation",
                           @"direction": @"outgoing"};
  return [self requestForNotificationsWithOffset:offset limit:limit dateFrom:dateFrom dateTo:dateTo options:options];
}

+ (PKRequest *)requestForNotificationWithNotificationId:(NSUInteger)notificationId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/notification/%ld/v2", (unsigned long)notificationId] method:PKRequestMethodGET];
}

+ (PKRequest *)requestToMarkNotificationAsViewedWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString *uri = [NSString stringWithFormat:@"/notification/%@/%ld/viewed", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  return [PKRequest requestWithURI:uri method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToMarkAllNotificationsAsViewed {
  return [PKRequest requestWithURI:@"/notification/viewed" method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToStarNotificationWithId:(NSUInteger)notificationId {
  NSString *uri = [NSString stringWithFormat:@"/notification/%ld/star", (unsigned long)notificationId];
  return [PKRequest requestWithURI:uri method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToUnstarNotificationWithId:(NSUInteger)notificationId {
  NSString *uri = [NSString stringWithFormat:@"/notification/%ld/star", (unsigned long)notificationId];
  return [PKRequest requestWithURI:uri method:PKRequestMethodDELETE];
}

@end
