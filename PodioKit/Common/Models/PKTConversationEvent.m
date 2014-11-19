//
//  PKTConversationEvent.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 13/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTConversationEvent.h"
#import "PKTByLine.h"
#import "PKTMessage.h"
#import "PKTConversationsAPI.h"
#import "PKTClient.h"
#import "NSArray+PKTAdditions.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTConversationEvent

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"eventID": @"event_id",
           @"conversationID": @"conversation_id",
           @"createdBy": @"created_by",
           @"createdOn": @"created_on"
           };
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)createdByValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTByLine class]];
}

+ (NSValueTransformer *)dataValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSDictionary *dict) {
    id data = dict;
    
    if (dict[@"message_id"] != nil) {
      data = [[PKTMessage alloc] initWithDictionary:dict];
    }
    
    return data;
  }];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchEventWithID:(NSUInteger)eventID {
  PKTRequest *request = [PKTConversationsAPI requestForConversationEventWithID:eventID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];
}

+ (PKTAsyncTask *)fetchAllInConversationWithID:(NSUInteger)conversationID offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTConversationsAPI requestForEventsInConversationWithID:conversationID offset:offset limit:limit];
  
  return [[[PKTClient currentClient] performRequest:request] map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *eventDict) {
      return [[self alloc] initWithDictionary:eventDict];
    }];
  }];
}

@end
