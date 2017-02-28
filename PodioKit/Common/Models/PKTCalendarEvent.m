//
//  PKTCalendarEvent.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTCalendarEvent.h"
#import "PKTApp.h"
#import "PKTCalendarAPI.h"
#import "PKTClient.h"
#import "NSArray+PKTAdditions.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTCalendarEvent

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"referenceType" : @"ref_type",
           @"referenceID" : @"ref_id",
           @"UID" : @"uid",
           @"descr" : @"description",
           @"startDate" : @"start_utc",
           @"startTime" : @"start_time",
           @"endDate" : @"end_utc",
           @"endTime" : @"end_time",
           @"forged" : @"forged",
           @"colorString" : @"color",
           @"categoryText" : @"category_text",
           };
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

+ (NSValueTransformer *)startDateValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)endDateValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)startTimeValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)endTimeValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)linkURLValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)appValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTApp class]];
}

#pragma mark - API

+ (PKTAsyncTask *)fetchAllFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  return [self fetchAllFromDate:fromDate toDate:toDate priority:0];
}

+ (PKTAsyncTask *)fetchAllFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  return [self fetchAllFromDate:fromDate toDate:toDate priority:priority includeTasks:YES];
}

+ (PKTAsyncTask *)fetchEventsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  return [self fetchEventsFromDate:fromDate toDate:toDate priority:0];
}

+ (PKTAsyncTask *)fetchEventsFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  return [self fetchAllFromDate:fromDate toDate:toDate priority:priority includeTasks:NO];
}

+ (PKTAsyncTask *)fetchAllFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)includeTasks {
  PKTRequest *request = [PKTCalendarAPI requestForGlobalCalendarWithFromDate:fromDate toDate:toDate priority:priority includeTasks:includeTasks];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class objectClass = [self class];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
      return [[objectClass alloc] initWithDictionary:dict];
    }];
  }];
  
  return task;
}

+ (PKTAsyncTask *)fetchAllForApp:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  return [self fetchAllForApp:appId fromDate:fromDate toDate:toDate priority:0];
}

+ (PKTAsyncTask *)fetchAllForApp:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  return [self fetchAllForApp:appId fromDate:fromDate toDate:toDate priority:priority includeTasks:YES];
}

+ (PKTAsyncTask *)fetchEventsForApp:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate {
  return [self fetchEventsForApp:appId fromDate:fromDate toDate:toDate priority:0];
}

+ (PKTAsyncTask *)fetchEventsForApp:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority {
  return [self fetchAllForApp:appId fromDate:fromDate toDate:toDate priority:priority includeTasks:NO];
}

+ (PKTAsyncTask *)fetchAllForApp:(NSUInteger)appId fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority includeTasks:(BOOL)includeTasks {
  
  PKTRequest *request = [PKTCalendarAPI requestForAppCalendarWithAppId:appId fromDate:fromDate toDate:toDate priority:priority includeTasks:includeTasks];
  PKTAsyncTask *requestTask = [[PKTClient currentClient] performRequest:request];
  
  Class objectClass = [self class];
  
  PKTAsyncTask *task = [requestTask map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
      return [[objectClass alloc] initWithDictionary:dict];
    }];
  }];
  
  return task;
}

@end
