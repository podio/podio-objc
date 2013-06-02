//
//  PKConversationAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/12/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKConversationAPI.h"

@implementation PKConversationAPI

+ (PKRequest *)requestToSendMessageWithText:(NSString *)text subject:(NSString *)subject participantUserIds:(NSArray *)participantUserIds {
  PKAssert(text != nil && [text length] > 0, @"Missing message text");
  PKAssert(participantUserIds != nil && [participantUserIds count] > 0, @"Missing message participants");
  
  PKRequest *request = [PKRequest requestWithURI:@"/conversation/" method:PKRequestMethodPOST];
  NSMutableDictionary *body = [[NSMutableDictionary alloc] init];
  body[@"text"] = text;
  body[@"participants"] = participantUserIds;
  
  if ([subject length] > 0) {
    body[@"subject"] = subject;
  }
  
  request.body = body;
  
  return request;
}

+ (PKRequest *)requestForConversationWithId:(NSUInteger)conversationId {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%ld", (unsigned long)conversationId];
  return [PKRequest requestWithURI:uri method:PKRequestMethodGET];
}

+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text {
  return [self requestToReplyToConversationWithId:conversationId withText:text fileIds:nil];
}

+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text fileIds:(NSArray *)fileIds {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%ld/reply/v2", (unsigned long)conversationId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST];
  
  request.body = [[NSMutableDictionary alloc] init];
  request.body[@"text"] = text;
  
  if ([fileIds count] > 0) {
    request.body[@"file_ids"] = fileIds;
  }
  
  return request;
}

+ (PKRequest *)requestToAddParticipantWithUserId:(NSUInteger)userId toConversationWithId:(NSUInteger)conversationId {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%ld/participant/", (unsigned long)conversationId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST];
  request.body = @{@"user_id": @(userId)};
  
  return request;
}


+ (PKRequest *)requestForConversationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForConversationsWithFlag:PKConversationFlagNone offset:offset limit:limit];
}

+ (PKRequest *)requestForConversationsWithFlag:(PKConversationFlag)flag offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = nil;
  
  switch (flag) {
    case PKConversationFlagStarred:
      request = [PKRequest getRequestWithURI:@"/conversation/starred/"];
      break;
    case PKConversationFlagUnread:
      request = [PKRequest getRequestWithURI:@"/conversation/unread/"];
      break;
    default:
      request = [PKRequest getRequestWithURI:@"/conversation/"];
      break;
  }
  
  request.offset = offset;
  
  request.parameters[@"offset"] = @(offset);
  
  if (limit > 0) {
    request.parameters[@"limit"] = @(limit);
  }
  
  return request;
}

+ (PKRequest *)requestForEventsForConversationWithId:(NSUInteger)conversationId offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/conversation/%ld/event/", (unsigned long)conversationId]];
  request.offset = offset;
  
  request.parameters[@"offset"] = @(offset);
  
  if (limit > 0) {
    request.parameters[@"limit"] = @(limit);
  }
  
  return request;
}

+ (PKRequest *)requestForEventWithId:(NSUInteger)eventId {
  return [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/conversation/event/%ld", (unsigned long)eventId]];
}

+ (PKRequest *)requestToStarConversationWithId:(NSUInteger)conversationId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/conversation/%ld/star", (unsigned long)conversationId]];
}

+ (PKRequest *)requestToUnstarConversationWithId:(NSUInteger)conversationId {
  return [PKRequest deleteRequestWithURI:[NSString stringWithFormat:@"/conversation/%ld/star", (unsigned long)conversationId]];
}

+ (PKRequest *)requestToReadConversationWithId:(NSUInteger)conversationId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/conversation/%ld/read", (unsigned long)conversationId]];
}

+ (PKRequest *)requestToUnreadConversationWithId:(NSUInteger)conversationId {
  return [PKRequest deleteRequestWithURI:[NSString stringWithFormat:@"/conversation/%ld/read", (unsigned long)conversationId]];
}

+ (PKRequest *)requestToLeaveConversationWithId:(NSUInteger)conversationId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/conversation/%ld/leave", (unsigned long)conversationId]];
}

@end
