//
//  PKGrantAPI.m
//  PodioKit
//
//  Created by Romain Briche on 18/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKGrantAPI.h"

@implementation PKGrantAPI

+ (PKRequest *)requestForOwnGrantsOnOrganizationWithId:(NSUInteger)orgId {
  NSString *uri = [NSString stringWithFormat:@"/grant/org/%ld/own/", (unsigned long)orgId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET objectMapping:nil];

  return request;
}

+ (PKRequest *)requestForGrantOnObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString *uri = [NSString stringWithFormat:@"/grant/%@/%ld/", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET objectMapping:nil];

  return request;
}

+ (PKRequest *)requestForGrantCountOnObjectWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString *uri = [NSString stringWithFormat:@"/grant/%@/%ld/count", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET objectMapping:nil];

  return request;
}

+ (PKRequest *)requestToCreateGrantOnObjectWithUserIds:(NSArray *)userIds message:(NSString *)message action:(PKGrantAction)action referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString *uri = [NSString stringWithFormat:@"/grant/%@/%ld", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST objectMapping:nil];

  NSMutableDictionary *params = [NSMutableDictionary new];
  if ([userIds count] > 0) {
    params[@"people"] = userIds;
  }
  if ([message length] > 0) {
    params[@"message"] = message;
  }
  if (action != PKGrantActionNone) {
    params[@"action"] = [PKConstants stringForGrantAction:action];
  }

  request.body = [params copy];

  return request;
}

+ (PKRequest *)requestToRemoveGrantOnObjectWithUserId:(NSUInteger)userId referenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString *uri = [NSString stringWithFormat:@"/grant/%@/%ld/%ld", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId, (unsigned long)userId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodDELETE objectMapping:nil];

  return request;
}

@end
