//
//  PKTConversationsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTConversationsAPI.h"

@implementation PKTConversationsAPI

+ (PKTRequest *)requestForConversationWithID:(NSUInteger)conversationID {
  NSString *path = [NSString stringWithFormat:@"/conversation/%lu", (unsigned long)conversationID];

  return [PKTRequest GETRequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestForConversationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:@"/conversation/" parameters:params];
}

+ (PKTRequest *)requestToSearchConversationsWithText:(NSString *)text includeParticipants:(BOOL)includeParticipants offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(text);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"text"] = text;
  params[@"participants"] = @(includeParticipants);
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:@"/conversation/search/" parameters:params];
}

+ (PKTRequest *)requestForConversationEventWithID:(NSUInteger)eventID {
  NSString *path = [NSString stringWithFormat:@"/conversation/event/%lu", (unsigned long)eventID];
  
  return [PKTRequest GETRequestWithPath:path parameters:nil];
}

+ (PKTRequest *)requestForEventsInConversationWithID:(NSUInteger)conversationID offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(conversationID > 0);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  NSString *path = [NSString stringWithFormat:@"/conversation/%lu/event/", (unsigned long)conversationID];
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:params];
  
  return request;
}

+ (PKTRequest *)requestToCreateConversationWithText:(NSString *)text subject:(NSString *)subject participantUserIDs:(NSArray *)userIDs {
  NSParameterAssert(text);
  NSParameterAssert([userIDs count] > 0);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"text"] = text;
  params[@"participants"] = userIDs;
  
  if (subject) {
    params[@"subject"] = subject;
  }
  
  return [PKTRequest POSTRequestWithPath:@"/conversation/v2/" parameters:params];
}

+ (PKTRequest *)requestToReplyToConversationWithID:(NSUInteger)conversationID text:(NSString *)text fileIDs:(NSArray *)fileIDs embedID:(NSUInteger)embedID {
  return [self requestToReplyToConversationWithID:conversationID text:text fileIDs:fileIDs embedID:embedID embedURL:nil];
}

+ (PKTRequest *)requestToReplyToConversationWithID:(NSUInteger)conversationID text:(NSString *)text fileIDs:(NSArray *)fileIDs embedURL:(NSURL *)embedURL {
  return [self requestToReplyToConversationWithID:conversationID text:text fileIDs:fileIDs embedID:0 embedURL:embedURL];
}

+ (PKTRequest *)requestToReplyToConversationWithID:(NSUInteger)conversationID text:(NSString *)text fileIDs:(NSArray *)fileIDs embedID:(NSUInteger)embedID embedURL:(NSURL *)embedURL {
  NSParameterAssert(conversationID > 0);
  NSParameterAssert([text length] > 0);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"text"] = text;
  
  if ([fileIDs count] > 0) {
    params[@"file_ids"] = fileIDs;
  }
  
  if (embedID > 0) {
    params[@"embed_id"] = @(embedID);
  } else if (embedURL) {
    params[@"embed_url"] = [embedURL absoluteString];
  }
  
  NSString *path = PKTRequestPath(@"/conversation/%lu/reply/v2", (unsigned long)conversationID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:params];
  
  return request;
}

+ (PKTRequest *)requestToMarkConversationWithIDAsRead:(NSUInteger)conversationID {
  NSString *path = PKTRequestPath(@"/conversation/%lu/read", (unsigned long)conversationID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:nil];
  
  return request;
}

+ (PKTRequest *)requestToMarkConversationWithIDAsUnread:(NSUInteger)conversationID {
  NSString *path = PKTRequestPath(@"/conversation/%lu/read", (unsigned long)conversationID);
  PKTRequest *request = [PKTRequest DELETERequestWithPath:path parameters:nil];
  
  return request;
}

@end
