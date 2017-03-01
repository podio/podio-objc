//
//  PKTCalendarAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCalendarAPI.h"
#import "NSDate+PKTAdditions.h"

@implementation PKTCalendarAPI



+ (PKTRequest *)requestForGlobalCalendarWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {

  return [self requestForGlobalCalendarWithFromDate:fromDate toDate:toDate priority:priority includeTasks:YES];
  
}

+ (PKTRequest *)requestForGlobalCalendarWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded {
  
  return [PKTRequest  GETRequestWithPath:@"/calendar/" parameters:[self getParamsForCalendarRequestFromDate:fromDate toDate:toDate priority:priority includeTasks:tasksIncluded]];
}

+ (PKTRequest *)requestForAppCalendarWithAppId:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  
  return [self requestForAppCalendarWithAppId:appId fromDate:fromDate toDate:toDate priority:priority includeTasks:YES];
  
}

+ (PKTRequest *)requestForAppCalendarWithAppId:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  NSString *requestPath = [NSString stringWithFormat:@"/calendar/app/%u", appId];
  
  return [PKTRequest  GETRequestWithPath:requestPath parameters: [self getParamsForCalendarRequestFromDate:fromDate toDate:toDate priority:priority includeTasks:tasksIncluded]];
}

+ (PKTRequest *)requestForSpaceCalendarWithSpaceId:(NSUInteger)spaceId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  
  return [self requestForSpaceCalendarWithSpaceId:spaceId fromDate:fromDate toDate:toDate priority:priority includeTasks:YES];
  
}

+ (PKTRequest *)requestForSpaceCalendarWithSpaceId:(NSUInteger)spaceId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  NSString *requestPath = [NSString stringWithFormat:@"/calendar/space/%u", spaceId];
  
  return [PKTRequest  GETRequestWithPath:requestPath parameters: [self getParamsForCalendarRequestFromDate:fromDate toDate:toDate priority:priority includeTasks:tasksIncluded]];
}

+ (NSDictionary *) getParamsForCalendarRequestFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded {
  
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  if (fromDate) {
    parameters[@"date_from"] = [fromDate pkt_UTCDateString];
  }
  
  if (toDate) {
    parameters[@"date_to"] = [toDate pkt_UTCDateString];
  }
  
  if (priority > 0) {
    parameters[@"priority"] = @(priority);
  }
  
  if (!tasksIncluded) {
    parameters[@"tasks"] = @(NO);
  }
  
  return parameters;
}

@end
