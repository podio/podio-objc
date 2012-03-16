//
//  PKContactAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/9/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseAPI.h"


typedef enum {
  PKRequestContactTypeFull = 0,
  PKRequestContactTypeMini,
} PKRequestContactType;

@interface PKContactAPI : PKBaseAPI

+ (PKRequest *)requestForGlobalContactsWithType:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForContactsInSpaceWithId:(NSUInteger)spaceId type:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForContactsInOrganizationWithId:(NSUInteger)orgId type:(PKRequestContactType)type contactTypes:(NSArray *)contactTypes excludeSelf:(BOOL)excludeSelf offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKRequest *)requestForContactWithProfileId:(NSUInteger)profileId;
+ (PKRequest *)requestForContactWithUserId:(NSUInteger)userId;

@end
