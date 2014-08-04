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
           @"endDate" : @"end_utc",
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
  PKTRequest *request = [PKTCalendarAPI requestForGlobalCalendarWithFromDate:fromDate toDate:toDate priority:priority];
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
