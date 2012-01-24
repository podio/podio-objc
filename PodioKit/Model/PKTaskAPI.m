//
//  PKTaskAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTaskAPI.h"
#import "NSDate+PKAdditions.h"

@implementation PKTaskAPI

+ (PKRequest *)requestForTaskWithId:(NSUInteger)taskId {
  NSString *uri = [NSString stringWithFormat:@"/task/%d", taskId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
  
  return request;
}

+ (PKRequest *)requestForTasksWithParameters:(NSDictionary *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:@"/task/" method:PKAPIRequestMethodGET];
  
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
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/assign", taskId] method:PKAPIRequestMethodPOST];
  request.body = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:userId] forKey:@"responsible"];
  
  return request;
}

+ (PKRequest *)requestToCompleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/complete", taskId] method:PKAPIRequestMethodPOST];
}

+ (PKRequest *)requestToIncompleteTaskWithId:(NSUInteger)taskId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/incomplete", taskId] method:PKAPIRequestMethodPOST];
}

+ (PKRequest *)requestToUpdateReferenceForTaskWithId:(NSUInteger)taskId referenceType:(PKReferenceType)referenceType referenceId:(NSUInteger)referenceId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/ref", taskId] method:PKAPIRequestMethodPUT];
  request.body = [NSDictionary dictionaryWithObjectsAndKeys:
                  [PKConstants stringForReferenceType:referenceType], @"ref_type", 
                  [NSNumber numberWithUnsignedInteger:referenceId], @"ref_id" , nil];
  
  return request;
}

+ (PKRequest *)requestToUpdatePrivacyForTaskWithId:(NSUInteger)taskId isPrivate:(BOOL)isPrivate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/private", taskId] method:PKAPIRequestMethodPUT];
  request.body = [NSDictionary dictionaryWithObject:[NSNumber numberWithBool:isPrivate] forKey:@"private"];
  
  return request;
}

+ (PKRequest *)requestToUpdateTextForTaskWithId:(NSUInteger)taskId text:(NSString *)text {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/text", taskId] method:PKAPIRequestMethodPUT];
  request.body = [NSDictionary dictionaryWithObject:text forKey:@"text"];
  
  return request;
}

+ (PKRequest *)requestToUpdateDescriptionForTaskWithId:(NSUInteger)taskId description:(NSString *)description {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/description", taskId] method:PKAPIRequestMethodPUT];
  request.body = [NSDictionary dictionaryWithObject:description forKey:@"description"];
  
  return request;
}

+ (PKRequest *)requestToUpdateDueDateForTaskWithId:(NSUInteger)taskId dueDate:(NSDate *)dueDate {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/task/%d/due_on", taskId] method:PKAPIRequestMethodPUT];
  
  if (dueDate != nil) {
    request.body = [NSDictionary dictionaryWithObject:[[dueDate pk_UTCDateFromLocalDate] pk_dateTimeString] forKey:@"due_on"];
  } else {
    request.body = [NSDictionary dictionaryWithObject:[NSNull null] forKey:@"due_on"];
  }
  
  return request;
}

@end
