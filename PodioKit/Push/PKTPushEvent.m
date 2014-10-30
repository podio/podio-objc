//
//  PKTPushEvent.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTPushEvent.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTPushEvent

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"eventType" : @"data.event",
           @"referenceID" : @"data.ref.id",
           @"referenceType" : @"data.ref.type",
           @"createdByType" : @"data.created_by.type",
           @"createdByID" : @"data.created_by.id",
           @"data" : @"data.data"
          };
}

+ (NSValueTransformer *)eventTypeValueTransformer {
  static NSDictionary *eventTypes;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    eventTypes = @{
                     @"typing": @(PKTPushEventTypeTyping),
                     @"viewing": @(PKTPushEventTypeViewing),
                     @"leaving": @(PKTPushEventTypeLeaving),
                     @"conversation_event": @(PKTPushEventTypeConversationEvent),
                     @"conversation_read": @(PKTPushEventTypeConversationRead),
                     @"conversation_unread": @(PKTPushEventTypeConversationUnread),
                     @"conversation_starred": @(PKTPushEventTypeConversationStarred),
                     @"conversation_unstarred": @(PKTPushEventTypeConversationUnstarred),
                     @"conversation_read_all": @(PKTPushEventTypeConversationReadAll),
                     @"conversation_starred_count": @(PKTPushEventTypeConversationStarredCount),
                     @"conversation_unread_count": @(PKTPushEventTypeConversationUnreadCount),
                     @"notification_unread": @(PKTPushEventTypeNotificationUnread)
                    };
  });
  
  return [NSValueTransformer pkt_transformerWithDictionary:eventTypes];
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

+ (NSValueTransformer *)createdByTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

@end
