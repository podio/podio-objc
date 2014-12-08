//
//  PKTConversationsAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTConversationsAPI : PKTBaseAPI

+ (PKTRequest *)requestForConversationWithID:(NSUInteger)conversationID;

+ (PKTRequest *)requestForConversationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestToSearchConversationsWithText:(NSString *)text includeParticipants:(BOOL)includeParticipants offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestForConversationEventWithID:(NSUInteger)eventID;

+ (PKTRequest *)requestForEventsInConversationWithID:(NSUInteger)conversationID offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestToCreateConversationWithText:(NSString *)text subject:(NSString *)subject participantUserIDs:(NSArray *)userIDs;

+ (PKTRequest *)requestToReplyToConversationWithID:(NSUInteger)conversationID text:(NSString *)text fileIDs:(NSArray *)fileIDs embedID:(NSUInteger)embedID;

+ (PKTRequest *)requestToReplyToConversationWithID:(NSUInteger)conversationID text:(NSString *)text fileIDs:(NSArray *)fileIDs embedURL:(NSURL *)embedURL;

+ (PKTRequest *)requestToMarkConversationWithIDAsRead:(NSUInteger)conversationID;

+ (PKTRequest *)requestToMarkConversationWithIDAsUnread:(NSUInteger)conversationID;

@end
