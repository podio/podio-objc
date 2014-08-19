//
//  PKTTasksAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTasksAPI.h"
#import "PKTConstants.h"
#import "NSDate+PKTAdditions.h"
#import "NSValueTransformer+PKTConstants.h"

@implementation PKTTasksAPI

+ (PKTRequest *)requestForTaskWithID:(NSUInteger)taskID {
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/task/%lu", (unsigned long)taskID) parameters:nil];
}

+ (PKTRequest *)requestForTasksWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *params = [[parameters queryParameters] mutableCopy];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:@"/task/" parameters:[params copy]];
}

+ (PKTRequest *)requestToCreateTaskWithText:(NSString *)text
                                description:(NSString *)description
                                      dueOn:(NSDate *)dueOn
                                  isPrivate:(BOOL)isPrivate
                          responsibleUserID:(NSUInteger)responsibleUserID
                                referenceID:(NSUInteger)referenceID
                              referenceType:(PKTReferenceType)referenceType
                                      files:(NSArray *)files {
  NSDictionary *params = [self queryParametersForTaskWithText:text
                                                  description:description
                                                        dueOn:dueOn
                                                    isPrivate:isPrivate
                                            responsibleUserID:responsibleUserID
                                                  referenceID:referenceID
                                                referenceType:referenceType
                                                        files:files];
  
  return [PKTRequest POSTRequestWithPath:PKTRequestPath(@"/task/") parameters:params];
}

+ (PKTRequest *)requestToUpdateTaskWithID:(NSUInteger)taskID
                                     text:(NSString *)text
                              description:(NSString *)description
                                    dueOn:(NSDate *)dueOn
                                isPrivate:(BOOL)isPrivate
                        responsibleUserID:(NSUInteger)responsibleUserID
                              referenceID:(NSUInteger)referenceID
                            referenceType:(PKTReferenceType)referenceType
                                    files:(NSArray *)files {
  NSDictionary *params = [self queryParametersForTaskWithText:text
                                                  description:description
                                                        dueOn:dueOn
                                                    isPrivate:isPrivate
                                            responsibleUserID:responsibleUserID
                                                  referenceID:referenceID
                                                referenceType:referenceType
                                                        files:files];
  
  return [PKTRequest PUTRequestWithPath:PKTRequestPath(@"/task/%lu", (unsigned long)taskID) parameters:params];
}

+ (PKTRequest *)requestToDeleteTaskWithID:(NSUInteger)taskID {
  return [PKTRequest DELETERequestWithPath:PKTRequestPath(@"/task/%lu", (unsigned long)taskID) parameters:nil];
}

+ (PKTRequest *)requestToAssignTaskWithID:(NSUInteger)taskID userID:(NSUInteger)userID {
  NSString *path = PKTRequestPath(@"/task/%lu/assign", (unsigned long)taskID);
  NSDictionary *params = @{
                           @"responsible" : userID > 0 ? @(userID) : [NSNull null]
                           };
  
  return [PKTRequest POSTRequestWithPath:path parameters:params];
}

+ (PKTRequest *)requestToCompleteTaskWithID:(NSUInteger)taskID {
  return [PKTRequest POSTRequestWithPath:PKTRequestPath(@"/task/%lu/complete", (unsigned long)taskID) parameters:nil];
}

+ (PKTRequest *)requestToIncompleteTaskWithID:(NSUInteger)taskID {
  return [PKTRequest POSTRequestWithPath:PKTRequestPath(@"/task/%lu/incomplete", (unsigned long)taskID) parameters:nil];
}

#pragma mark - Helpers

+ (NSDictionary *)queryParametersForTaskWithText:(NSString *)text
                                     description:(NSString *)description
                                           dueOn:(NSDate *)dueOn
                                       isPrivate:(BOOL)isPrivate
                               responsibleUserID:(NSUInteger)responsibleUserID
                                     referenceID:(NSUInteger)referenceID
                                   referenceType:(PKTReferenceType)referenceType
                                           files:(NSArray *)files {
  NSParameterAssert(text);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"text"] = text;
  params[@"private"] = @(isPrivate);
  
  if (description) {
    params[@"description"] = description;
  }
  
  if (dueOn) {
    params[@"due_on"] = [dueOn pkt_UTCDateTimeString];
  }
  
  if (responsibleUserID > 0) {
    params[@"responsible"] = @(responsibleUserID);
  }
  
  if (referenceID > 0 && referenceType != PKTReferenceTypeUnknown) {
    params[@"ref_id"] = @(referenceID);
    params[@"ref_type"] = [NSValueTransformer pkt_stringFromReferenceType:referenceType];
  }
  
  if (files) {
    params[@"file_ids"] = files;
  }
  
  return [params copy];
}

@end
