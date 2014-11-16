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
  NSString *path = [NSString stringWithFormat:@"/conversation/%lu", conversationID];

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

+ (PKTRequest *)requestForEventsInConversationWithID:(NSUInteger)conversationID offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSParameterAssert(conversationID > 0);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  NSString *path = [NSString stringWithFormat:@"/conversation/%lu/event/", conversationID];
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:params];
  
  return request;
}

@end
