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
  NSString *uri = [NSString stringWithFormat:@"/task/%ld", (unsigned long)taskId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET];
  
  return request;
}

+ (PKRequest *)requestForTasksWithParameters:(NSDictionary *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:@"/task/" method:PKRequestMethodGET];
  
  [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)offset] forKey:@"offset"];
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)limit] forKey:@"limit"];
  }
  
  [request.parameters addEntriesFromDictionary:parameters];
  
  return request;
}

+ (PKRequest *)requestForMyTasksForUserId:(NSUInteger)userId offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
  [parameters setObject:@"due_date" forKey:@"grouping"];
  [parameters setObject:@"full" forKey:@"view"];
  [parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)userId] forKey:@"responsible"];
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
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/assign", (unsigned long)taskId] method:PKRequestMethodPOST];
  request.body = @{@"responsible": @(userId)};
  
  return request;
}

+ (PKRequest *)requestToCompleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/complete", (unsigned long)taskId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToIncompleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/incomplete", (unsigned long)taskId] method:PKRequestMethodPOST];
}

+ (PKRequest *)requestToUpdateReferenceForTaskWithId:(NSUInteger)taskId referenceType:(PKReferenceType)referenceType referenceId:(NSUInteger)referenceId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/ref", (unsigned long)taskId] method:PKRequestMethodPUT];
  request.body = @{@"ref_type": [PKConstants stringForReferenceType:referenceType], 
                  @"ref_id": @(referenceId)};
  
  return request;
}

+ (PKRequest *)requestToUpdatePrivacyForTaskWithId:(NSUInteger)taskId isPrivate:(BOOL)isPrivate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/private", (unsigned long)taskId] method:PKRequestMethodPUT];
  request.body = @{@"private": @(isPrivate)};
  
  return request;
}

+ (PKRequest *)requestToUpdateTextForTaskWithId:(NSUInteger)taskId text:(NSString *)text {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/text", (unsigned long)taskId] method:PKRequestMethodPUT];
  request.body = @{@"text": text};
  
  return request;
}

+ (PKRequest *)requestToUpdateDescriptionForTaskWithId:(NSUInteger)taskId description:(NSString *)description {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/description", (unsigned long)taskId] method:PKRequestMethodPUT];
  request.body = @{@"description": description};
  
  return request;
}

+ (PKRequest *)requestToUpdateDueDateForTaskWithId:(NSUInteger)taskId dueDate:(NSDate *)dueDate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/due_on", (unsigned long)taskId] method:PKRequestMethodPUT];
  
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
  return [self requestToCreateTaskWithText:text
                               description:description
                                   dueDate:dueDate
                                  reminder:nil
                               responsible:responsible
                           responsibleType:PKReferenceTypeProfile
                                 isPrivate:isPrivate
                               referenceId:referenceId
                             referenceType:referenceType
                                   fileIds:fileIds];
}

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(NSDate *)dueDate
                               responsible:(NSUInteger)responsible
                           responsibleType:(PKReferenceType)responsibleType
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds {
  return [self requestToCreateTaskWithText:text
                               description:description
                                   dueDate:dueDate
                                  reminder:nil
                               responsible:responsible
                           responsibleType:responsibleType
                                 isPrivate:isPrivate
                               referenceId:referenceId
                             referenceType:referenceType
                                   fileIds:fileIds];
}

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(NSDate *)dueDate
                                  reminder:(NSNumber *)reminder
                               responsible:(NSUInteger)responsible
                           responsibleType:(PKReferenceType)responsibleType
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds {
  BOOL hasReference = referenceType != PKReferenceTypeNone && referenceId > 0;
  
  PKRequest *request = nil;
  
  if (hasReference) {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%@/%ld/", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId] method:PKRequestMethodPOST];
  } else {
    request = [PKRequest requestWithURI:@"/task/" method:PKRequestMethodPOST];
  }
  
  NSMutableDictionary *body = [NSMutableDictionary dictionary];
  [body setObject:text forKey:@"text"];
  
  if (responsible > 0) {
    [body setObject:@(responsible) forKey:@"responsible"];
  }
  if (responsible > 0 && (responsibleType == PKReferenceTypeProfile || responsibleType == PKReferenceTypeSpace)) {
    NSString *typeString;
    if (responsibleType == PKReferenceTypeProfile) {
      typeString = @"user";
    } else if (responsibleType == PKReferenceTypeSpace) {
      typeString = @"space";
    }
    
    [body setObject:@{@"type": typeString, @"id": @(responsible)} forKey:@"responsible"];
  }
  
  if (description != nil) {
    [body setObject:description forKey:@"description"];
  }
  
  if (dueDate != nil) {
    [body setObject:[[dueDate pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"due_on"];
  }
  
  if (reminder != nil) {
    [body setObject:@{@"remind_delta": reminder} forKey:@"reminder"];
  }
  
  if (hasReference) {
    [body setObject:[PKConstants stringForReferenceType:referenceType] forKey:@"ref_type"];
    [body setObject:@(referenceId) forKey:@"ref_id"];
    [body setObject:@(isPrivate) forKey:@"private"];
  }
  
  if (fileIds) {
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
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds {
  return [self requestToUpdateTaskWithId:taskId
                                    text:text
                             description:description
                                 dueDate:dueDate
                                reminder:nil
                             responsible:responsible
                               isPrivate:isPrivate
                             referenceId:referenceId
                           referenceType:referenceType
                                 fileIds:fileIds];
}

+ (PKRequest *)requestToUpdateTaskWithId:(NSUInteger)taskId
                                    text:(NSString *)text
                             description:(NSString *)description
                                 dueDate:(NSDate *)dueDate
                                reminder:(NSNumber *)reminder
                             responsible:(NSUInteger)responsible
                               isPrivate:(BOOL)isPrivate
                             referenceId:(NSUInteger)referenceId
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld", (unsigned long)taskId] method:PKRequestMethodPUT];
  
  NSMutableDictionary *body = [NSMutableDictionary dictionary];
  [body setObject:text forKey:@"text"];
  
  if (responsible > 0) {
    [body setObject:@(responsible) forKey:@"responsible"];
  }
  
  [body setObject:(description ? description : [NSNull null]) forKey:@"description"];
  
  NSString *dateString = [dueDate pk_dateString];
  [body setObject:([dateString length] > 0 ? dateString : [NSNull null]) forKey:@"due_date"];
  
  NSString *timeString = [dueDate pk_timeString];
  [body setObject:([timeString length] > 0 ? timeString : [NSNull null]) forKey:@"due_time"];
  
  if (reminder != nil) {
    if ([reminder intValue] < 0) {
      [body setObject:@{@"remind_delta": [NSNull null]} forKey:@"reminder"];
    } else {
      [body setObject:@{@"remind_delta": reminder} forKey:@"reminder"];
    }
  }
  
  if (referenceType != PKReferenceTypeNone && referenceId > 0) {
    [body setObject:[PKConstants stringForReferenceType:referenceType] forKey:@"ref_type"];
    [body setObject:@(referenceId) forKey:@"ref_id"];
    [body setObject:@(isPrivate) forKey:@"private"];
  }
  
  if (fileIds) {
    [body setObject:fileIds forKey:@"file_ids"];
  }
  
  request.body = body;
  
  return request;
}

+ (PKRequest *)requestToDeleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld", (unsigned long)taskId] method:PKRequestMethodDELETE];
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
    [request.parameters setObject:[NSString stringWithFormat:@"%ld", (unsigned long)spaceId] forKey:@"space_id"];
  }
  
  return request;
}

@end
