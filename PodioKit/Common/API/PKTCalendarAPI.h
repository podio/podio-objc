//
//  PKTCalendarAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTCalendarAPI : PKTBaseAPI

+ (PKTRequest *)requestForGlobalCalendarWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority;

+ (PKTRequest *)requestForGlobalCalendarWithFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded;

+ (PKTRequest *)requestForAppCalendarWithAppId:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority;

+ (PKTRequest *)requestForAppCalendarWithAppId:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded;

+ (NSDictionary *)getParamsForCalendarRequestFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)tasksIncluded;

@end
