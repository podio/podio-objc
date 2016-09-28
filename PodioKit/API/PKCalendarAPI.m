//
//  PKCalendarAPI.m
//  PodioKit
//
//  Created by Lauge Jepsen on 11/06/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKCalendarAPI.h"
#import "NSDate+PKFormatting.h"

@implementation PKCalendarAPI

#pragma mark - Public

+ (PKRequest *)requestForGlobalCalendarEventsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  return [PKCalendarAPI requestForCalendarEventsUsingURLString:@"/calendar/" fromDate:fromDate toDate:toDate priority:priority];
}

+ (PKRequest *)requestForCalendarEventsForSpace:(NSUInteger)spaceId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  return [PKCalendarAPI requestForCalendarEventsUsingURLString:[NSString stringWithFormat:@"/calendar/space/%ld", (unsigned long)spaceId] fromDate:fromDate toDate:toDate priority:priority];
}

+ (PKRequest *)requestForCalendarEventsForApp:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {

  return [PKCalendarAPI requestForCalendarEventsUsingURLString:[NSString stringWithFormat:@"/calendar/app/%ld", (unsigned long)appId] fromDate:fromDate toDate:toDate priority:priority];
}


#pragma mark - Private

+ (PKRequest *)requestForCalendarEventsUsingURLString:(NSString *)urlString fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  PKRequest *request = [PKRequest requestWithURI:urlString method:PKRequestMethodGET];
  [request.parameters setObject:[fromDate pk_localDateString] forKey:@"date_from"];
  [request.parameters setObject:[toDate pk_localDateString] forKey:@"date_to"];
  [request.parameters setObject:@(priority) forKey:@"priority"];
  
  return request;
}

@end
