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
#import "PKTResponse.h"
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

+ (void)fetchAllFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate completion:(void (^)(NSArray *events, NSError *error))completion {
  [self fetchAllFromDate:fromDate toDate:toDate priority:0 completion:completion];
}

+ (void)fetchAllFromDate:(NSDate *)fromDate toDate:(NSDate *)toDate priority:(NSUInteger)priority completion:(void (^)(NSArray *events, NSError *error))completion {
  PKTRequest *request = [PKTCalendarAPI requestForGlobalCalendarWithFromDate:fromDate toDate:toDate priority:priority];
  [[self client] performRequest:request completion:^(PKTResponse *response, NSError *error) {
    NSArray *events = nil;
    
    if (!error) {
      events = [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *dict) {
        return [[PKTCalendarEvent alloc] initWithDictionary:dict];
      }];
    }
    
    if (completion) completion(events, error);
  }];
}

@end
