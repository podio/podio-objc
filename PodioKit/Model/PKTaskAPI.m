//
//  PKTaskAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTaskAPI.h"

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

@end
