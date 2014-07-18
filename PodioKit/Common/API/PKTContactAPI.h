//
//  PKTContactAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

typedef NS_OPTIONS(NSUInteger, PKTContactType) {
  PKTContactTypeUser = 1 << 0,
  PKTContactTypeSpace = 1 << 1,
};

typedef NS_ENUM(NSUInteger, PKTContactOrdering) {
  PKTContactOrderingDefault = 0,
  PKTContactOrderingAssign,
  PKTContactOrderingMessage,
  PKTContactOrderingReference,
  PKTContactOrderingAlert,
  PKTContactOrderingOverall
};

@interface PKTContactAPI : PKTBaseAPI

+ (PKTRequest *)requestForContactWithUserID:(NSUInteger)userID;

+ (PKTRequest *)requestForContactWithProfileID:(NSUInteger)profileID;

+ (PKTRequest *)requestForContactsWithProfileIDs:(NSArray *)profileIDs;

+ (PKTRequest *)requestForContactsInWorkspaceWithID:(NSUInteger)workspaceID contactType:(PKTContactType)contactType excludeSelf:(BOOL)excludeSelf ordering:(PKTContactOrdering)ordering fields:(NSDictionary *)fields requiredFields:(NSArray *)requiredFields offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestForContactsOfType:(PKTContactType)contactType excludeSelf:(BOOL)excludeSelf ordering:(PKTContactOrdering)ordering fields:(NSDictionary *)fields requiredFields:(NSArray *)requiredFields offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
