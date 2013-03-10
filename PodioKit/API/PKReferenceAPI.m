//
//  PKReferenceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/8/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceAPI.h"

@implementation PKReferenceAPI

+ (PKRequest *)requestToSearchReferenceWithTarget:(PKReferenceTarget)target targetParameters:(NSDictionary *)targetParameters query:(NSString *)query limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest postRequestWithURI:@"/reference/search"];
  
  request.body = [NSMutableDictionary dictionary];
  
  switch (target) {
    case PKReferenceTargetItemField:
      request.body[@"target"] = @"item_field";
      break;
    default:
      break;
  }

  if ([query length] > 0) {
    request.body[@"text"] = query;
  }
  
  if (limit > 0) {
    request.body[@"limit"] = @(limit);
  }
  
  if ([targetParameters count] > 0) {
    request.body[@"target_params"] = targetParameters;
  }
  
  return request;
}

@end
