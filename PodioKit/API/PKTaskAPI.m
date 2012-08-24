//
//  PKTaskAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTaskAPI.h"
#import "NSDate+PKAdditions.h"

@implementation PKTaskAPI

+ (PKRequest *)requestForTaskWithId:(NSUInteger)taskId {
  NSString *uri = [NSString stringWithFormat:@"/task/%d", taskId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET];
  
  return request;
}

+ (PKRequest *)requestForTasksWithParameters:(NSDictionary *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:@"/task/" method:PKRequestMethodGET];
  
  [request.parameters setObject:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", limit] forKey:@"limit"];
  }
  
  [request.parameters addEntriesFromDictionary:parameters];
  
  return request;
}

+ (PKRequest *)requestForMyTasksForUserId:(NSUInteger)userId offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters setObject:@"due_date" forKey:@"grouping"];
  [parameters setObject:@"full" forKey:@"view"];
  [parameters setObject:[NSString stringWithFormat:@"%d", userId] forKey:@"responsible"];
  [parameters setObject:@"0" forKey:@"completed"];
  
  return [self requestForTasksWithParameters:parameters offset:offset limit:limit];
}

+ (PKRequest *)requestForDelegatedTasksOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters setObject:@"due_date" forKey:@"grouping"];
  [parameters setObject:@"full" forKey:@"view"];
  [parameters setObject:@"0" forKey:@"completed"];
  [parameters setObject:@"1" forKey:@"reassigned"];
  
  return [self requestForTasksWithParameters:parameters offset:offset limit:limit];
}

+ (PKRequest *)requestForCompletedTasksWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters setObject:@"completed_on" forKey:@"grouping"];
  [parameters setObject:@"full" forKey:@"view"];
  [parameters setObject:@"1" forKey:@"completed"];
  [parameters setObject:@"user:0" forKey:@"completed_by"];
  
  return [self requestForTasksWithParameters:parameters offset:offset limit:limit];
}

+ (PKRequest *)requestToAssignTaskWithId:(NSUInteger)taskId toUserWithId:(NSUInteger)userId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/assign", taskId] method:PKRequestMethodPOST];
  request.body = @{@"responsible": @(userId)};
  
  return request;
}

+ (PKRequest *)requestToCompleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/complete", taskId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToIncompleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/incomplete", taskId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToUpdateReferenceForTaskWithId:(NSUInteger)taskId referenceType:(PKReferenceType)referenceType referenceId:(NSUInteger)referenceId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/ref", taskId] method:PKRequestMethodPUT];
  request.body = @{@"ref_type": [PKConstants stringForReferenceType:referenceType], 
                  @"ref_id": @(referenceId)};
  
  return request;
}

+ (PKRequest *)requestToUpdatePrivacyForTaskWithId:(NSUInteger)taskId isPrivate:(BOOL)isPrivate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/private", taskId] method:PKRequestMethodPUT];
  request.body = @{@"private": @(isPrivate)};
  
  return request;
}

+ (PKRequest *)requestToUpdateTextForTaskWithId:(NSUInteger)taskId text:(NSString *)text {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/text", taskId] method:PKRequestMethodPUT];
  request.body = @{@"text": text};
  
  return request;
}

+ (PKRequest *)requestToUpdateDescriptionForTaskWithId:(NSUInteger)taskId description:(NSString *)description {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/description", taskId] method:PKRequestMethodPUT];
  request.body = @{@"description": description};
  
  return request;
}

+ (PKRequest *)requestToUpdateDueDateForTaskWithId:(NSUInteger)taskId dueDate:(NSDate *)dueDate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/due_on", taskId] method:PKRequestMethodPUT];
  
  if (dueDate != nil) {
    request.body = @{@"due_on": [[dueDate pk_UTCDateFromLocalDate] pk_dateTimeString]};
  } else {
    request.body = @{@"due_on": [NSNull null]};
  }
  
  return request;
}

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text 
                               description:(NSString *)description 
                                   dueDate:(NSDate *)dueDate 
                               responsible:(NSUInteger)responsible 
                                 isPrivate:(BOOL)isPrivate 
                               referenceId:(NSUInteger)referenceId 
                             referenceType:(PKReferenceType)referenceType 
                                   fileIds:(NSArray *)fileIds {
  BOOL hasReference = referenceType != PKReferenceTypeNone && referenceId > 0;
  
  PKRequest *request = nil;
  
  if (hasReference) {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%@/%d/", [PKConstants stringForReferenceType:referenceType], referenceId] method:PKRequestMethodPOST];
  } else {
    request = [PKRequest requestWithURI:@"/task/" method:PKRequestMethodPOST];
  }
  
  NSMutableDictionary *body = [NSMutableDictionary dictionary];
  [body setObject:text forKey:@"text"];
  
  if (responsible > 0) {
    [body setObject:@(responsible) forKey:@"responsible"];
  }
  
  if (description != nil) {
    [body setObject:description forKey:@"description"];
  }
  
  if (dueDate != nil) {
    [body setObject:[[dueDate pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"due_on"];
  }
  
  if (hasReference) {
    [body setObject:[PKConstants stringForReferenceType:referenceType] forKey:@"ref_type"];
    [body setObject:@(referenceId) forKey:@"ref_id"];
    [body setObject:@(isPrivate) forKey:@"private"];
  }
  
  if ([fileIds count] > 0) {
    [body setObject:fileIds forKey:@"file_ids"];
  }
  
  request.body = body;
  
  return request;
}

+ (PKRequest *)requestToUpdateTaskWithId:(NSUInteger)taskId 
                                    text:(NSString *)text 
                             description:(NSString *)description 
                                 dueDate:(NSDate *)dueDate 
                             responsible:(NSUInteger)responsible 
                               isPrivate:(BOOL)isPrivate 
                             referenceId:(NSUInteger)referenceId 
                           referenceType:(PKReferenceType)referenceType {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d", taskId] method:PKRequestMethodPUT];
  
  NSMutableDictionary *body = [NSMutableDictionary dictionary];
  [body setObject:text forKey:@"text"];
  
  if (responsible > 0) {
    [body setObject:@(responsible) forKey:@"responsible"];
  }
  
  if (description != nil) {
    [body setObject:description forKey:@"description"];
  }
  
  NSString *dateString = [dueDate pk_dateString];
  if ([dateString length] > 0) {
    [body setObject:dateString forKey:@"due_date"];
  }
  
  NSString *timeString = [dueDate pk_timeString];
  if ([timeString length] > 0) {
    [body setObject:timeString forKey:@"due_time"];
  }
  
  if (referenceType != PKReferenceTypeNone && referenceId > 0) {
    [body setObject:[PKConstants stringForReferenceType:referenceType] forKey:@"ref_type"];
    [body setObject:@(referenceId) forKey:@"ref_id"];
    [body setObject:@(isPrivate) forKey:@"private"];
  }
  
  request.body = body;
  
  return request;
}

+ (PKRequest *)requestToDeleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d", taskId] method:PKRequestMethodDELETE];
}

+ (PKRequest *)requestForTaskTotalsWithTime:(PKTaskTotalsTime)time {
  return [self requestForTaskTotalsWithTime:time spaceId:0];
}

+ (PKRequest *)requestForTaskTotalsWithTime:(PKTaskTotalsTime)time spaceId:(NSUInteger)spaceId {
  NSString *timeString = nil;
  
  switch (time) {
    case PKTaskTotalsTimeOverdue:
      timeString = @"overdue";
      break;
    case PKTaskTotalsTimeDue:
      timeString = @"due";
      break;
    case PKTaskTotalsTimeToday:
      timeString = @"today";
      break;
    case PKTaskTotalsTimeAll:
    default:
      timeString = @"all";
      break;
  }
  
  NSString *uri = [NSString stringWithFormat:@"/task/total/%@", timeString];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET];
  
  if (spaceId > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", spaceId] forKey:@"space_id"];
  }
  
  return request;
}

@end
