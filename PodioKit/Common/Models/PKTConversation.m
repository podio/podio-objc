//
//  PKTConversation.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTConversation.h"
#import "PKTConversationEvent.h"
#import "PKTPushCredential.h"
#import "PKTProfile.h"
#import "PKTConversationsAPI.h"
#import "PKTMacros.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "NSArray+PKTAdditions.h"

@interface PKTConversation ()

@property (nonatomic) BOOL unread;

@end

@implementation PKTConversation

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"conversationID" : @"conversation_id",
           @"createdOn" : @"created_on",
           @"lastEventOn" : @"last_event_on",
           @"pushCredential" : @"push"
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

+ (NSValueTransformer *)pushCredentialValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTPushCredential class]];
}

#pragma mark - Public

+ (PKTAsyncTask *)fetchConversationWithID:(NSUInteger)conversationID {
  PKTRequest *request = [PKTConversationsAPI requestForConversationWithID:conversationID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [[self alloc] initWithDictionary:response.body];
  }];
}

+ (PKTAsyncTask *)fetchAllWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTConversationsAPI requestForConversationsWithOffset:offset limit:limit];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *conversationDict) {
      return [[self alloc] initWithDictionary:conversationDict];
    }];
  }];
}

+ (PKTAsyncTask *)searchWithText:(NSString *)text includeParticipants:(BOOL)includeParticipants offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKTRequest *request = [PKTConversationsAPI requestToSearchConversationsWithText:text includeParticipants:includeParticipants offset:offset limit:limit];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [response.body pkt_mappedArrayWithBlock:^id(NSDictionary *conversationDict) {
      return [[self alloc] initWithDictionary:conversationDict];
    }];
  }];
}

+ (PKTAsyncTask *)createConversationWithText:(NSString *)text subject:(NSString *)subject participantUserIDs:(NSArray *)userIDs {
  return [self createConversationWithText:text subject:subject participantUserIDs:userIDs fileIDs:nil];
}

+ (PKTAsyncTask *)createConversationWithText:(NSString *)text subject:(NSString *)subject participantUserIDs:(NSArray *)userIDs fileIDs:(NSArray *)fileIDs {
  PKTRequest *request = [PKTConversationsAPI requestToCreateConversationWithText:text subject:subject participantUserIDs:userIDs fileIDs:fileIDs];
  
  return [[PKTClient currentClient] performRequest:request];
}

- (PKTAsyncTask *)replyWithText:(NSString *)text files:(NSArray *)files embedID:(NSUInteger)embedID {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  PKTRequest *request = [PKTConversationsAPI requestToReplyToConversationWithID:self.conversationID
                                                                           text:text
                                                                        fileIDs:fileIDs
                                                                        embedID:embedID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [[PKTConversationEvent alloc] initWithDictionary:response.body];
  }];
}

- (PKTAsyncTask *)replyWithText:(NSString *)text files:(NSArray *)files embedURL:(NSURL *)embedURL {
  NSArray *fileIDs = [files valueForKey:@"fileID"];
  PKTRequest *request = [PKTConversationsAPI requestToReplyToConversationWithID:self.conversationID
                                                                           text:text
                                                                        fileIDs:fileIDs
                                                                       embedURL:embedURL];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  return [task map:^id(PKTResponse *response) {
    return [[PKTConversationEvent alloc] initWithDictionary:response.body];
  }];
}

- (PKTAsyncTask *)markAsRead {
  PKTRequest *request = [PKTConversationsAPI requestToMarkConversationWithIDAsRead:self.conversationID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  BOOL previousValue = self.unread;
  self.unread = NO;
  
  PKT_WEAK_SELF weakSelf = self;
  return [task then:^(id result, NSError *error) {
    if (error) {
      weakSelf.unread = previousValue;
    }
  }];
}

- (PKTAsyncTask *)markAsUnread {
  PKTRequest *request = [PKTConversationsAPI requestToMarkConversationWithIDAsUnread:self.conversationID];
  PKTAsyncTask *task = [[PKTClient currentClient] performRequest:request];
  
  BOOL previousValue = self.unread;
  self.unread = YES;
  
  PKT_WEAK_SELF weakSelf = self;
  return [task then:^(id result, NSError *error) {
    if (error) {
      weakSelf.unread = previousValue;
    }
  }];
}

@end
