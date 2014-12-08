//
//  PKTConversation.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTAsyncTask, PKTPushCredential;

@interface PKTConversation : PKTModel

@property (nonatomic, readonly) NSUInteger conversationID;
@property (nonatomic, copy, readonly) NSString *subject;
@property (nonatomic, copy, readonly) NSString *excerpt;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) NSDate *lastEventOn;
@property (nonatomic, copy, readonly) NSArray *participants;
@property (nonatomic, readonly) BOOL unread;
@property (nonatomic, readonly) BOOL starred;
@property (nonatomic, copy, readonly) PKTPushCredential *pushCredential;

+ (PKTAsyncTask *)fetchConversationWithID:(NSUInteger)conversationID;
+ (PKTAsyncTask *)fetchAllWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKTAsyncTask *)searchWithText:(NSString *)text includeParticipants:(BOOL)includeParticipants offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTAsyncTask *)createConversationWithText:(NSString *)text subject:(NSString *)subject participantUserIDs:(NSArray *)userIDs;

- (PKTAsyncTask *)replyWithText:(NSString *)text files:(NSArray *)files embedID:(NSUInteger)embedID;
- (PKTAsyncTask *)replyWithText:(NSString *)text files:(NSArray *)files embedURL:(NSURL *)embedURL;

- (PKTAsyncTask *)markAsRead;
- (PKTAsyncTask *)markAsUnread;

@end
