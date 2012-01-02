//
//  PKTaskAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTaskAPI.h"

@implementation PKTaskAPI

+ (PKRequest *)requestForActiveTasksWithProfileId:(NSUInteger)profileId {
  PKRequest *request = [PKRequest requestWithURI:@"/task/" method:PKAPIRequestMethodGET];
  
  [request.parameters setObject:@"due_date" forKey:@"grouping"];
  [request.parameters setObject:@"full" forKey:@"view"];
  
  [request.parameters setObject:[NSString stringWithFormat:@"%d", profileId] forKey:@"responsible"];
  [request.parameters setObject:@"0" forKey:@"completed"];
  [request.parameters setObject:@"0" forKey:@"reassigned"];
  
  return request;
}

+ (PKRequest *)requestForTaskWithId:(NSUInteger)taskId {
  NSString *uri = [NSString stringWithFormat:@"/task/%d", taskId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKAPIRequestMethodGET];
  
  return request;
}

@end
