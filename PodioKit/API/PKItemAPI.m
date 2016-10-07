//
//  PKItemAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemAPI.h"

@implementation PKItemAPI

+ (PKRequest *)requestForItemWithId:(NSUInteger)itemId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%ld", (unsigned long)itemId] method:PKRequestMethodGET];
}

+ (PKRequest *)requestToDeleteItemWithId:(NSUInteger)itemId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%ld", (unsigned long)itemId] method:PKRequestMethodDELETE];
}

+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId viewId:(NSUInteger)viewId filters:(NSDictionary *)filters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = nil;
  if (filters) {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%ld/filter/", (unsigned long)appId] method:PKRequestMethodPOST];
  } else if (viewId > 0) {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%ld/filter/%ld/", (unsigned long)appId, (unsigned long)viewId] method:PKRequestMethodPOST];
  } else {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%ld/", (unsigned long)appId] method:PKRequestMethodGET];
  }
  
  request.offset = offset;
  
  if (viewId > 0 || filters) {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setObject:@NO forKey:@"remember"];
    
    if (filters) {
      [body setObject:filters forKey:@"filters"];
    }
    
    if (offset > 0) {
      [body setObject:@(offset) forKey:@"offset"];
    }
    
    if (limit > 0) {
      [body setObject:@(limit) forKey:@"limit"];
    }
    
    request.body = body;
  } else {
    // Sort by created date by default
    [request.parameters setObject:@"created_on" forKey:@"sort_by"];
    
    if (offset > 0) {
      [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)offset] forKey:@"offset"];
    }
    
    if (limit > 0) {
      [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)limit] forKey:@"limit"];
    }
  }
  
  return request;
}

+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId viewId:(NSUInteger)viewId sortBy:(NSString *)sortBy descending:(BOOL)descending offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = nil;
  
  if (viewId > 0) {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%ld/filter/%ld/", (unsigned long)appId, (unsigned long)viewId] method:PKRequestMethodPOST];
  } else {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%ld/filter/", (unsigned long)appId] method:PKRequestMethodPOST];
  }
  
  request.offset = offset;
  
  NSMutableDictionary *body = [NSMutableDictionary dictionary];
  [body setObject:@NO forKey:@"remember"];
  
  if (offset > 0) {
    [body setObject:@(offset) forKey:@"offset"];
  }
  
  if (limit > 0) {
    [body setObject:@(limit) forKey:@"limit"];
  }
  
  if (sortBy) {
    [body setObject:sortBy forKey:@"sort_by"];
  }
  
  if (descending) {
    [body setObject:@(YES) forKey:@"sort_desc"];
  } else {
    [body setObject:@(NO) forKey:@"sort_desc"];
  }
  
  request.body = body;
  
  return request;
}

+ (PKRequest *)requestToCreateItemWithAppId:(NSUInteger)appId fields:(NSArray *)fields fileIds:(NSArray *)fileIds {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/app/%ld/", (unsigned long)appId] method:PKRequestMethodPOST];
  
  request.body = [NSMutableDictionary dictionaryWithObject:fields forKey:@"fields"];
  if (fileIds) {
    [request.body setObject:fileIds forKey:@"file_ids"];
  }
  
  return request;
}

+ (PKRequest *)requestToUpdateItemFields:(NSArray *)fields itemId:(NSUInteger)itemId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%ld/value", (unsigned long)itemId] method:PKRequestMethodPUT];
  
  request.body = [NSMutableDictionary dictionaryWithObject:fields forKey:@"fields"];
  
  return request;
}

+ (PKRequest *)requestToUpdateItemWithId:(NSUInteger)itemId fields:(NSArray *)fields fileIds:(NSArray *)fileIds {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%ld", (unsigned long)itemId] method:PKRequestMethodPUT];
  
  request.body = [NSMutableDictionary dictionaryWithObject:fields forKey:@"fields"];
  if (fileIds) {
    [request.body setObject:fileIds forKey:@"file_ids"];
  }
  
  return request;
}

+ (PKRequest *)requestToSetParticipationForItemWithId:(NSUInteger)itemId status:(PKMeetingParticipantStatus)status {
  PKAssert(status != PKMeetingParticipantStatusNone, @"Participation is invalid, %lu", (unsigned long)status);
  
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/%ld/participation", (unsigned long)itemId] method:PKRequestMethodPUT];
  
  NSString *statusString = [PKConstants stringForMeetingParticipantStatus:status];
  request.body = @{@"status": statusString};
  
  return request;
}

+ (PKRequest *)requestToFindItemsForFieldWithId:(NSUInteger)fieldId text:(NSString *)text notItemIds:(NSArray *)notItemIds sortType:(PKItemAPISortType)sortType {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/item/field/%ld/find", (unsigned long)fieldId] method:PKRequestMethodGET];

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
  
  if ([notItemIds count] > 0) {
    [request.parameters setObject:[notItemIds componentsJoinedByString:@","] forKey:@"not_item_id"];
  }
  
  if ([text length] > 0) {
    [request.parameters setObject:text forKey:@"text"];
  }
  
  return request;
}

+ (PKRequest *)requestForReferencesToItemWithId:(NSUInteger)itemId fieldId:(NSUInteger)fieldId limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/item/%ld/reference/field/%ld", (unsigned long)itemId, (unsigned long)fieldId]];
  
  if (limit > 0) {
    request.parameters[@"limit"] = [NSString stringWithFormat:@"%ld", (unsigned long)limit];
  }
  
  return request;
}

+ (PKRequest *)requestToSetReminderForItemWithId:(NSUInteger)itemId reminderDelta:(int)delta {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/reminder/item/%ld", (unsigned long)itemId] method:PKRequestMethodPUT]; //TODO: THIS IS WORKING!!!!!
  
  request.body = [[NSMutableDictionary alloc] initWithCapacity:1];
  [request.body setValue:@(delta) forKey:@"remind_delta"];
  
  return request;
}

@end
