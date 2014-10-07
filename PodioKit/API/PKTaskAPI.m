//
//  PKTaskAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTaskAPI.h"
#import "NSDate+PKFormatting.h"
#import "PKConstants.h"

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

+ (PKRequest *)requestToUpdateDueDateForTaskWithId:(NSUInteger)taskId dueDate:(PKDate *)dueDate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%ld/due_on", (unsigned long)taskId] method:PKRequestMethodPUT];
  
  NSMutableDictionary *body = [NSMutableDictionary new];
  
  if (dueDate) {
    if (dueDate.includesTimeComponent) {
      body[@"due_on"] = [dueDate pk_UTCDateTimeString];
    } else {
      body[@"due_date"] = [dueDate pk_UTCDateString];
    }
  } else {
    body[@"due_on"] = [NSNull null];
  }

  request.body = body;
  
  return request;
}

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(PKDate *)dueDate
                               responsible:(NSUInteger)responsible
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds
                                  labelIds:(NSArray *)labelIds {
  return [self requestToCreateTaskWithText:text
                               description:description
                                   dueDate:dueDate
                                  reminder:nil
                               responsible:responsible
                           responsibleType:PKReferenceTypeProfile
                                 isPrivate:isPrivate
                               referenceId:referenceId
                             referenceType:referenceType
                                   fileIds:fileIds
                                  labelIds:labelIds];
}

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(PKDate *)dueDate
                               responsible:(NSUInteger)responsible
                           responsibleType:(PKReferenceType)responsibleType
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds
                                  labelIds:(NSArray *)labelIds {
  return [self requestToCreateTaskWithText:text
                               description:description
                                   dueDate:dueDate
                                  reminder:nil
                               responsible:responsible
                           responsibleType:responsibleType
                                 isPrivate:isPrivate
                               referenceId:referenceId
                             referenceType:referenceType
                                   fileIds:fileIds
                                  labelIds:labelIds];
}

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(PKDate *)dueDate
                                  reminder:(NSNumber *)reminder
                               responsible:(NSUInteger)responsible
                           responsibleType:(PKReferenceType)responsibleType
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds
                                  labelIds:(NSArray *)labelIds {
  PKRequest *request = nil;
  
  if (referenceType != PKReferenceTypeNone && referenceId > 0) {
    request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%@/%ld/", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId] method:PKRequestMethodPOST];
  } else {
    request = [PKRequest requestWithURI:@"/task/" method:PKRequestMethodPOST];
  }
  
  request.body = [self taskParametersWithText:text
                                  description:description
                                      dueDate:dueDate
                                     reminder:reminder
                                  responsible:responsible
                              responsibleType:responsibleType
                                    isPrivate:isPrivate
                                  referenceId:referenceId
                                referenceType:referenceType
                                      fileIds:fileIds
                                     labelIds:labelIds];
  
  return request;
}

+ (PKRequest *)requestToUpdateTaskWithId:(NSUInteger)taskId 
                                    text:(NSString *)text 
                             description:(NSString *)description 
                                 dueDate:(PKDate *)dueDate 
                             responsible:(NSUInteger)responsible 
                               isPrivate:(BOOL)isPrivate 
                             referenceId:(NSUInteger)referenceId 
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds
                                labelIds:(NSArray *)labelIds {
  return [self requestToUpdateTaskWithId:taskId
                                    text:text
                             description:description
                                 dueDate:dueDate
                                reminder:nil
                             responsible:responsible
                               isPrivate:isPrivate
                             referenceId:referenceId
                           referenceType:referenceType
                                 fileIds:fileIds
                                labelIds:labelIds];
}

+ (PKRequest *)requestToUpdateTaskWithId:(NSUInteger)taskId
                                    text:(NSString *)text
                             description:(NSString *)description
                                 dueDate:(PKDate *)dueDate
                                reminder:(NSNumber *)reminder
                             responsible:(NSUInteger)responsible
                               isPrivate:(BOOL)isPrivate
                             referenceId:(NSUInteger)referenceId
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds
                                labelIds:(NSArray *)labelIds {
  NSString *uri = [NSString stringWithFormat:@"/task/%ld", (unsigned long)taskId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPUT];
  
  request.body = [self taskParametersWithText:text
                                  description:description
                                      dueDate:dueDate
                                     reminder:reminder
                                  responsible:responsible
                              responsibleType:PKReferenceTypeNone
                                    isPrivate:isPrivate
                                  referenceId:referenceId
                                referenceType:referenceType
                                      fileIds:fileIds
                                     labelIds:labelIds];
  
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

#pragma mark - Helpers

+ (NSDictionary *)taskParametersWithText:(NSString *)text
                             description:(NSString *)description
                                 dueDate:(PKDate *)dueDate
                                reminder:(NSNumber *)reminder
                             responsible:(NSUInteger)responsible
                         responsibleType:(PKReferenceType)responsibleType
                               isPrivate:(BOOL)isPrivate
                             referenceId:(NSUInteger)referenceId
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds
                                labelIds:(NSArray *)labelIds {
  NSParameterAssert(text);
  
  NSMutableDictionary *params = [NSMutableDictionary dictionary];
  params[@"text"] = text;
  params[@"description"] = description ? description : [NSNull null];
  
  if (responsible > 0) {
    if (responsibleType == PKReferenceTypeProfile || responsibleType == PKReferenceTypeSpace) {
      NSString *typeString;
      
      if (responsibleType == PKReferenceTypeProfile) {
        typeString = @"user";
      } else if (responsibleType == PKReferenceTypeSpace) {
        typeString = @"space";
      }
      
      params[@"responsible"] = @{@"type": typeString, @"id": @(responsible)};
    } else {
      params[@"responsible"] = @(responsible);
    }
  }
  
  if (dueDate) {
    if (dueDate.includesTimeComponent) {
      params[@"due_on"] = [dueDate pk_UTCDateTimeString];
    } else {
      params[@"due_date"] = [dueDate pk_UTCDateString];
    }
  } else {
    params[@"due_on"] = [NSNull null];
  }
  
  if (reminder) {
    id reminderDelta = [reminder intValue] >= 0 ? reminder : [NSNull null];
    params[@"reminder"] = @{@"remind_delta": reminderDelta};
  }
  
  if (referenceType != PKReferenceTypeNone && referenceId > 0) {
    params[@"ref_type"] = [PKConstants stringForReferenceType:referenceType];
    params[@"ref_id"] = @(referenceId);
    params[@"private"] = @(isPrivate);
  }
  
  if (fileIds) {
    [params setObject:fileIds forKey:@"file_ids"];
  }
  
  if (labelIds) {
    params[@"labels"] = labelIds;
  }
  
  return [params copy];
}

@end
