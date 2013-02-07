//
//  PKConversationAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/12/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKConversationAPI : PKBaseAPI

+ (PKRequest *)requestToSendMessageWithText:(NSString *)text subject:(NSString *)subject participantUserIds:(NSArray *)participantUserIds;
+ (PKRequest *)requestForConversationWithId:(NSUInteger)conversationId;
+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text;
+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text fileIds:(NSArray *)fileIds;
+ (PKRequest *)requestToAddParticipantWithUserId:(NSUInteger)userId toConversationWithId:(NSUInteger)conversationId;

@end
