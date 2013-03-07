//
//  PKConversationAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/12/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

typedef NS_ENUM(NSUInteger, PKConversationFlag) {
  PKConversationFlagStarred,
  PKConversationFlagUnread,
};

@interface PKConversationAPI : PKBaseAPI

+ (PKRequest *)requestToSendMessageWithText:(NSString *)text subject:(NSString *)subject participantUserIds:(NSArray *)participantUserIds;
+ (PKRequest *)requestForConversationWithId:(NSUInteger)conversationId;
+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text;
+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text fileIds:(NSArray *)fileIds;
+ (PKRequest *)requestToAddParticipantWithUserId:(NSUInteger)userId toConversationWithId:(NSUInteger)conversationId;

+ (PKRequest *)requestForConversationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForConversationsWithFlag:(PKConversationFlag)flag offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKRequest *)requestForEventsForConversationWithId:(NSUInteger)conversationId offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
