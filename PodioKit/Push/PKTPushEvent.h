//
//  PKTPushEvent.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

typedef NS_ENUM(NSUInteger, PKTPushEventType) {
  PKTPushEventTypeUnknown,
  
  PKTPushEventTypeTyping,
  PKTPushEventTypeViewing,
  PKTPushEventTypeLeaving,
  
  PKTPushEventTypeCommentCreate,
  PKTPushEventTypeCommentUpdate,
  PKTPushEventTypeCommentDelete,
  
  PKTPushEventTypeConversationStarredCount,
  PKTPushEventTypeConversationUnreadCount,
  PKTPushEventTypeConversationRead,
  PKTPushEventTypeConversationUnread,
  PKTPushEventTypeConversationStarred,
  PKTPushEventTypeConversationUnstarred,
  PKTPushEventTypeConversationReadAll,
  PKTPushEventTypeConversationEvent,
  
  PKTPushEventTypeFileAttach,
  PKTPushEventTypeFileDelete,
  
  PKTPushEventTypeCreate,
  PKTPushEventTypeUpdate,
  PKTPushEventTypeDelete,
  
  PKTPushEventTypeRatingLikeCreate,
  PKTPushEventTypeRatingLikeDelete,
  
  PKTPushEventTypeStreamCreate,
  
  PKTPushEventTypeSubscribe,
  PKTPushEventTypeUnsubscribe,
  
  PKTPushEventTypeNotificationUnread,
  PKTPushEventTypeNotificationCreate,
};

@interface PKTPushEvent : PKTModel

@property (nonatomic, copy, readonly) NSString *channel;
@property (nonatomic, readonly) PKTPushEventType eventType;
@property (nonatomic, readonly) PKTReferenceType referenceType;
@property (nonatomic, readonly) NSUInteger referenceID;
@property (nonatomic, readonly) NSUInteger createdByID;
@property (nonatomic, readonly) PKTReferenceType createdByType;
@property (nonatomic, strong, readonly) id data;

@end
