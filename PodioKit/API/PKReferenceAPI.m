//
//  PKReferenceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/8/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceAPI.h"
#import "NSString+URL.h"

@implementation PKReferenceAPI

+ (PKRequest *)requestToSearchReferenceWithTarget:(PKReferenceTarget)target targetParameters:(NSDictionary *)targetParameters query:(NSString *)query limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest postRequestWithURI:@"/reference/search"];
  
  request.body = [NSMutableDictionary dictionary];

  NSString *targetString = [self stringForReferenceTarget:target];
  if (targetString) {
    request.body[@"target"] = targetString;
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

+ (PKRequest *)requestToResolveURLString:(NSString *)URLString {
  PKRequest *request = [PKRequest getRequestWithURI:@"/reference/resolve"];
  
  if (URLString) {
    request.parameters[@"url"] = URLString;
  }
  
  return request;
}

+ (NSString *)stringForReferenceTarget:(PKReferenceTarget)target {
  NSString *reference = nil;
  switch (target) {
    case PKReferenceTargetTaskReference:
      reference = @"task_reference";
      break;
    case PKReferenceTargetTaskResponsible:
      reference = @"task_responsible";
      break;
    case PKReferenceTargetAlert:
      reference = @"alert";
      break;
    case PKReferenceTargetConversation:
      reference = @"conversation";
      break;
    case PKReferenceTargetConversationPresence:
      reference = @"conversation_presence";
      break;
    case PKReferenceTargetGrant:
      reference = @"grant";
      break;
    case PKReferenceTargetItemField:
      reference = @"item_field";
      break;
    case PKReferenceTargetItemCreatedBy:
      reference = @"item_created_by";
      break;
    case PKReferenceTargetItemCreatedVia:
      reference = @"item_created_via";
      break;
    case PKReferenceTargetItemTags:
      reference = @"item_tags";
      break;
    case PKReferenceTargetGlobalNav:
      reference = @"global_nav";
      break;
    default:
      break;
  }

  return reference;
}

@end
