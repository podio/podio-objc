//
//  PKTTasksAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTTaskRequestParameters.h"
#import "PKTConstants.h"

@interface PKTTasksAPI : PKTBaseAPI

+ (PKTRequest *)requestForTaskWithID:(NSUInteger)taskID;

+ (PKTRequest *)requestForTasksWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestToCreateTaskWithText:(NSString *)text
                                description:(NSString *)description
                                      dueOn:(NSDate *)dueOn
                                  isPrivate:(BOOL)isPrivate
                          responsibleUserID:(NSUInteger)responsibleUserID
                                referenceID:(NSUInteger)referenceID
                              referenceType:(PKTReferenceType)referenceType
                                      files:(NSArray *)files;

+ (PKTRequest *)requestToUpdateTaskWithID:(NSUInteger)taskID
                                     text:(NSString *)text
                              description:(NSString *)description
                                    dueOn:(NSDate *)dueOn
                                isPrivate:(BOOL)isPrivate
                        responsibleUserID:(NSUInteger)responsibleUserID
                              referenceID:(NSUInteger)referenceID
                            referenceType:(PKTReferenceType)referenceType
                                    files:(NSArray *)files;

+ (PKTRequest *)requestToDeleteTaskWithID:(NSUInteger)taskID;

+ (PKTRequest *)requestToAssignTaskWithID:(NSUInteger)taskID userID:(NSUInteger)userID;

+ (PKTRequest *)requestToCompleteTaskWithID:(NSUInteger)taskID;

+ (PKTRequest *)requestToIncompleteTaskWithID:(NSUInteger)taskID;

@end
