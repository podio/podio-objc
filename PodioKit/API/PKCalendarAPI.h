//
//  PKCalendarAPI.h
//  PodioKit
//
//  Created by Lauge Jepsen on 11/06/2014.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKCalendarAPI : PKBaseAPI

+ (PKRequest *)requestForGlobalCalendarEventsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority;
+ (PKRequest *)requestForCalendarEventsForSpace:(NSUInteger)spaceId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority;

@end
