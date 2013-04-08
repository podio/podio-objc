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
  PKAssert(subject != nil && [subject length] > 0, @"Missing message subject");
  PKAssert(participantUserIds != nil && [participantUserIds count] > 0, @"Missing message participants");
  
  PKRequest *request = [PKRequest requestWithURI:@"/conversation/" method:PKRequestMethodPOST];
  request.body = @{@"text": text, @"subject": subject, @"participants": participantUserIds};
  
  return request;
}

+ (PKRequest *)requestForConversationWithId:(NSUInteger)conversationId {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%d", conversationId];
  return [PKRequest requestWithURI:uri method:PKRequestMethodGET];
}

+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text {
  return [self requestToReplyToConversationWithId:conversationId withText:text fileIds:nil];
}

+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text fileIds:(NSArray *)fileIds {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%d/reply", conversationId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST];
  
  request.body = [[NSMutableDictionary alloc] init];
  request.body[@"text"] = text;
  
  if ([fileIds count] > 0) {
    request.body[@"file_ids"] = fileIds;
  }
  
  return request;
}

+ (PKRequest *)requestToAddParticipantWithUserId:(NSUInteger)userId toConversationWithId:(NSUInteger)conversationId {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%d/participant/", conversationId];
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
  PKRequest *request = [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/conversation/%d/event/", conversationId]];
  request.offset = offset;
  
  request.parameters[@"offset"] = @(offset);
  
  if (limit > 0) {
    request.parameters[@"limit"] = @(limit);
  }
  
  return request;
}

+ (PKRequest *)requestToStarConversationWithId:(NSUInteger)conversationId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/conversation/%d/star", conversationId]];
}

+ (PKRequest *)requestToUnstarConversationWithId:(NSUInteger)conversationId {
  return [PKRequest deleteRequestWithURI:[NSString stringWithFormat:@"/conversation/%d/star", conversationId]];
}

+ (PKRequest *)requestToReadConversationWithId:(NSUInteger)conversationId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/conversation/%d/read", conversationId]];
}

+ (PKRequest *)requestToUnreadConversationWithId:(NSUInteger)conversationId {
  return [PKRequest deleteRequestWithURI:[NSString stringWithFormat:@"/conversation/%d/read", conversationId]];
}

@end
