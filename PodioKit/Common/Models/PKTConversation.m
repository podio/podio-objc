//
//  PKTConversation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTConversation.h"
#import "PKTProfile.h"
#import "PKTConversationsAPI.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTConversation

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"conversationID" : @"conversation_id",
           @"createdOn" : @"created_on",
           @"lastEventOn" : @"last_event_on"
           };
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)lastEventOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)participantsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTProfile class]];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchAllWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTConversationsAPI requestForConversationsWithOffset:offset limit:limit];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *conversationDict) {
      return [[self alloc] initWithDictionary:conversationDict];
    }];
  }];
}

@end
