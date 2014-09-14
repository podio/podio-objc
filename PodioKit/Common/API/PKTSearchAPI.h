//
//  PKTSearchAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTSearchQuery.h"

@interface PKTSearchAPI : PKTBaseAPI

+ (PKTRequest *)requestToSearchGloballyWithQuery:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestToSearchInOrganizationWithID:(NSUInteger)organizationID query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestToSearchInWorkspaceWithID:(NSUInteger)workspaceID Query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKTRequest *)requestToSearchInAppWithID:(NSUInteger)appID query:(PKTSearchQuery *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
