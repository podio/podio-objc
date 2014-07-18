//
//  PKSubscriptionAPI.m
//  PodioKit
//
//  Created by Romain Briche on 17/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKSubscriptionAPI.h"

@implementation PKSubscriptionAPI

+ (PKRequest *)requestToSubscribeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
	NSString * uri = [NSString stringWithFormat:@"/subscription/%@/%ld", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodPOST objectMapping:nil];

  return request;
}

+ (PKRequest *)requestToUnsubscribeWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
	NSString *uri = [NSString stringWithFormat:@"/subscription/%@/%ld", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodDELETE objectMapping:nil];

  return request;
}

+ (PKRequest *)requestForSubscriptionsWithReferenceId:(NSUInteger)referenceId referenceType:(PKReferenceType)referenceType {
  NSString *uri = [NSString stringWithFormat:@"/subscription/%@/%ld", [PKConstants stringForReferenceType:referenceType], (unsigned long)referenceId];
  PKRequest *request = [PKRequest requestWithURI:uri method:PKRequestMethodGET objectMapping:nil];

  return request;
}

@end
