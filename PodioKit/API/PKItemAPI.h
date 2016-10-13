//
//  PKItemAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"

typedef enum {
  PKItemAPISortTypeNone = 0,
  PKItemAPISortTypeCreatedOn,
  PKItemAPISortTypeTitle,
} PKItemAPISortType;

@interface PKItemAPI : PKBaseAPI

+ (PKRequest *)requestForItemWithId:(NSUInteger)itemId;
+ (PKRequest *)requestToDeleteItemWithId:(NSUInteger)itemId;
+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId viewId:(NSUInteger)viewId filters:(NSDictionary *)filters offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId viewId:(NSUInteger)viewId sortBy:(NSString *)sortBy descending:(BOOL)descending offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestToCreateItemWithAppId:(NSUInteger)appId fields:(NSArray *)fields fileIds:(NSArray *)fileIds;
+ (PKRequest *)requestToUpdateItemFields:(NSArray *)fields itemId:(NSUInteger)itemId;
+ (PKRequest *)requestToUpdateItemWithId:(NSUInteger)itemId fields:(NSArray *)fields fileIds:(NSArray *)fileIds;
+ (PKRequest *)requestToSetParticipationForItemWithId:(NSUInteger)itemId status:(PKMeetingParticipantStatus)status;
+ (PKRequest *)requestToFindItemsForFieldWithId:(NSUInteger)fieldId text:(NSString *)text notItemIds:(NSArray *)notItemIds sortType:(PKItemAPISortType)sortType;
+ (PKRequest *)requestForReferencesToItemWithId:(NSUInteger)itemId fieldId:(NSUInteger)fieldId limit:(NSUInteger)limit;
+ (PKRequest *)requestToSetReminderForItemWithId:(NSUInteger)itemId reminderDelta:(NSInteger)delta;
+ (PKRequest *)requestToSetRecurrenceForItemWithId:(NSUInteger)itemId recurrenceOptions:(NSDictionary *)recurrenceOptions;

@end
