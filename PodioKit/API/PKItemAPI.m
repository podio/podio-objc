//
//  PKItemAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemAPI.h"

@implementation PKItemAPI

+ (PKRequest *)requestForItemWithId:(NSUInteger)itemId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%d", itemId] method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId filterId:(NSUInteger)filterId offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%d/", appId] method:PKAPIRequestMethodGET];
  request.offset = offset;
  
  if (offset > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
  }
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", limit] forKey:@"limit"];
  }
  
  if (filterId > 0) {
    [request.parameters setObject:[NSNumber numberWithUnsignedInteger:filterId] forKey:@"filter_id"];
  } else {
    // Sort by created date by default
    [request.parameters setObject:@"created_on" forKey:@"sort_by"];
  }
  
  return request;
}

+ (PKRequest *)requestToCreateItemWithAppId:(NSUInteger)appId fields:(NSArray *)fields fileIds:(NSArray *)fileIds {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%d/", appId] method:PKAPIRequestMethodPOST];
  
  request.body = [NSMutableDictionary dictionaryWithObject:fields forKey:@"fields"];
  if (fileIds != nil && [fileIds count] > 0) {
    [request.body setObject:fileIds forKey:@"file_ids"];
  }
  
  return request;
}

+ (PKRequest *)requestToUpdateItemFields:(NSArray *)fields itemId:(NSUInteger)itemId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%d/value", itemId] method:PKAPIRequestMethodPUT];
  
  request.body = [NSMutableDictionary dictionaryWithObject:fields forKey:@"fields"];
  
  return request;
}

+ (PKRequest *)requestToUpdateItemWithId:(NSUInteger)itemId fields:(NSArray *)fields fileIds:(NSArray *)fileIds {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%d", itemId] method:PKAPIRequestMethodPUT];
  
  request.body = [NSMutableDictionary dictionaryWithObject:fields forKey:@"fields"];
  if (fileIds != nil && [fileIds count] > 0) {
    [request.body setObject:fileIds forKey:@"file_ids"];
  }
  
  return request;
}

+ (PKRequest *)requestToSetParticipationForItemWithId:(NSUInteger)itemId status:(PKMeetingParticipantStatus)status {
  PKAssert(status != PKMeetingParticipantStatusNone, @"Participation is invalid, %d", status);
  
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%d/participation", itemId] method:PKAPIRequestMethodPUT];
  
  NSString *statusString = [PKConstants stringForMeetingParticipantStatus:status];
  request.body = [NSDictionary dictionaryWithObject:statusString forKey:@"status"];
  
  return request;
}

@end
