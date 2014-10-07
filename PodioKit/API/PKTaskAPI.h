//
//  PKTaskAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"
#import "PKDate.h"

@interface PKTaskAPI : PKBaseAPI

+ (PKRequest *)requestForTaskWithId:(NSUInteger)taskId;
+ (PKRequest *)requestForTasksWithParameters:(NSDictionary *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKRequest *)requestForMyTasksForUserId:(NSUInteger)userId offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForDelegatedTasksOffset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForCompletedTasksWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKRequest *)requestToAssignTaskWithId:(NSUInteger)taskId toUserWithId:(NSUInteger)userId;
+ (PKRequest *)requestToCompleteTaskWithId:(NSUInteger)taskId;
+ (PKRequest *)requestToIncompleteTaskWithId:(NSUInteger)taskId;
+ (PKRequest *)requestToUpdateReferenceForTaskWithId:(NSUInteger)taskId referenceType:(PKReferenceType)referenceType referenceId:(NSUInteger)referenceId;
+ (PKRequest *)requestToUpdatePrivacyForTaskWithId:(NSUInteger)taskId isPrivate:(BOOL)isPrivate;
+ (PKRequest *)requestToUpdateTextForTaskWithId:(NSUInteger)taskId text:(NSString *)text;
+ (PKRequest *)requestToUpdateDescriptionForTaskWithId:(NSUInteger)taskId description:(NSString *)description;
+ (PKRequest *)requestToUpdateDueDateForTaskWithId:(NSUInteger)taskId dueDate:(PKDate *)dueDate;

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text 
                               description:(NSString *)description 
                                   dueDate:(PKDate *)dueDate
                               responsible:(NSUInteger)responsible 
                                 isPrivate:(BOOL)isPrivate 
                               referenceId:(NSUInteger)referenceId 
                             referenceType:(PKReferenceType)referenceType 
                                   fileIds:(NSArray *)fileIds
                                  labelIds:(NSArray *)labelIds;

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(PKDate *)dueDate
                                  reminder:(NSNumber *)reminder
                               responsible:(NSUInteger)responsible
                           responsibleType:(PKReferenceType)responsibleType
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds
                                  labelIds:(NSArray *)labelIds;

+ (PKRequest *)requestToCreateTaskWithText:(NSString *)text
                               description:(NSString *)description
                                   dueDate:(PKDate *)dueDate
                               responsible:(NSUInteger)responsible
                           responsibleType:(PKReferenceType)responsibleType
                                 isPrivate:(BOOL)isPrivate
                               referenceId:(NSUInteger)referenceId
                             referenceType:(PKReferenceType)referenceType
                                   fileIds:(NSArray *)fileIds
                                  labelIds:(NSArray *)labelIds;

+ (PKRequest *)requestToUpdateTaskWithId:(NSUInteger)taskId 
                                    text:(NSString *)text 
                             description:(NSString *)description 
                                 dueDate:(PKDate *)dueDate
                             responsible:(NSUInteger)responsible 
                               isPrivate:(BOOL)isPrivate 
                             referenceId:(NSUInteger)referenceId 
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds
                                labelIds:(NSArray *)labelIds;

+ (PKRequest *)requestToUpdateTaskWithId:(NSUInteger)taskId
                                    text:(NSString *)text
                             description:(NSString *)description
                                 dueDate:(PKDate *)dueDate
                                reminder:(NSNumber *)reminder
                             responsible:(NSUInteger)responsible
                               isPrivate:(BOOL)isPrivate
                             referenceId:(NSUInteger)referenceId
                           referenceType:(PKReferenceType)referenceType
                                 fileIds:(NSArray *)fileIds
                                labelIds:(NSArray *)labelIds;

+ (PKRequest *)requestToDeleteTaskWithId:(NSUInteger)taskId;

+ (PKRequest *)requestForTaskTotalsWithTime:(PKTaskTotalsTime)time;
+ (PKRequest *)requestForTaskTotalsWithTime:(PKTaskTotalsTime)time spaceId:(NSUInteger)spaceId;

@end
