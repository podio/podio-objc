//
//  PKConversationAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/12/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKConversationAPI.h"

@implementation PKConversationAPI

+ (PKRequest *)requestToSendMessageWithText:(NSString *)text subject:(NSString *)subject participantUserIds:(NSArray *)participantUserIds {
  PKAssert(text != nil && [text length] > 0, @"Missing message text");
  PKAssert(subject != nil && [subject length] > 0, @"Missing message subject");
  PKAssert(participantUserIds != nil && [participantUserIds count] > 0, @"Missing message participants");
  
  PKRequest *request = [PKRequest requestWithURI:@"/conversation/" method:PKAPIRequestMethodPOST];
  request.body = [NSDictionary dictionaryWithObjectsAndKeys:text, @"text", subject, @"subject", participantUserIds, @"participants", nil];
  
  return request;
}

+ (PKRequest *)requestForConversationWithId:(NSUInteger)conversationId {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%d", conversationId];
  return [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestToReplyToConversationWithId:(NSUInteger)conversationId withText:(NSString *)text {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%d/reply", conversationId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodPOST];
  request.body = [NSDictionary dictionaryWithObject:text forKey:@"text"];
  
  return request;
}

+ (PKRequest *)requestToAddParticipantWithUserId:(NSUInteger)userId toConversationWithId:(NSUInteger)conversationId {
  NSString * uri = [NSString stringWithFormat:@"/conversation/%d/participant/", conversationId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodPOST];
  request.body = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:userId] forKey:@"user_id"];
  
  return request;
}

@end
