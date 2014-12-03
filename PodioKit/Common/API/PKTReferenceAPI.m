//
//  PKTReferenceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/12/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReferenceAPI.h"

@implementation PKTReferenceAPI

#pragma mark - Public

+ (PKTRequest *)requestToSearchForReferenceWithText:(NSString *)text target:(PKTReferenceTarget)target targetParameters:(NSDictionary *)targetParamers limit:(NSUInteger)limit {
  NSParameterAssert(text);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"text"] = text;
  params[@"target"] = [self stringForTarget:target];
  
  if ([targetParamers count] > 0) {
    params[@"target_params"] = targetParamers;
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest POSTRequestWithPath:@"/reference/search" parameters:params];
}

#pragma mark - Private

+ (NSString *)stringForTarget:(PKTReferenceTarget)target {
  static NSDictionary *targetMap = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    targetMap = @{
                  @(PKTReferenceTargetTaskReference): @"task_reference",
                  @(PKTReferenceTargetTaskResponsible): @"task_responsible",
                  @(PKTReferenceTargetAlert): @"alert",
                  @(PKTReferenceTargetConversation): @"conversation",
                  @(PKTReferenceTargetConversationPresence): @"conversation_presence",
                  @(PKTReferenceTargetGrant): @"grant",
                  @(PKTReferenceTargetItemField): @"item_field",
                  @(PKTReferenceTargetItemCreatedBy): @"item_created_by",
                  @(PKTReferenceTargetItemCreatedVia): @"item_created_via",
                  @(PKTReferenceTargetItemTags): @"item_tags",
                  @(PKTReferenceTargetGlobalNav): @"global_nav",
                  @(PKTReferenceTargetScriptVariables): @"script_variables",
                  @(PKTReferenceTargetApps): @"apps",
                  @(PKTReferenceTargetInvite): @"invite"
                  };
  });
  
  NSString *string = targetMap[@(target)];
  NSAssert(string != nil, @"Unsupported target %lu", (unsigned long)target);
  
  return string;
}

@end
