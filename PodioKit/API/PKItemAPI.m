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

+ (PKRequest *)requestToDeleteItemWithId:(NSUInteger)itemId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%d", itemId] method:PKAPIRequestMethodDELETE];
}

+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId viewId:(NSUInteger)viewId offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%d/", appId] method:PKAPIRequestMethodGET];
  request.offset = offset;
  
  if (offset > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
  }
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", limit] forKey:@"limit"];
  }
  
  if (viewId > 0) {
    [request.parameters setObject:@"0" forKey:@"remember"];
    [request.parameters setObject:[NSString stringWithFormat:@"%d", viewId] forKey:@"view_id"];
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
  request.body = @{@"status": statusString};
  
  return request;
}

+ (PKRequest *)requestToFindItemsForFieldWithId:(NSUInteger)fieldId text:(NSString *)text notItemId:(NSUInteger)notItemId sortType:(PKItemAPISortType)sortType {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/field/%d/find", fieldId] method:PKAPIRequestMethodGET];

  switch (sortType) {
    case PKItemAPISortTypeCreatedOn:
      [request.parameters setObject:@"created_on" forKey:@"sort"];
      break;
    case PKItemAPISortTypeTitle:
      [request.parameters setObject:@"title" forKey:@"sort"];
      break;
    default:
      break;
  }
  
  if (notItemId > 0) {
    [request.parameters setObject:@(notItemId) forKey:@"not_item_id"];
  }
  
  if ([text length] > 0) {
    [request.parameters setObject:text forKey:@"text"];
  }
  
  return request;
}

@end
