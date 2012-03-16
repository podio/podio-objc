//
//  PKSearchAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/2/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKSearchAPI : PKBaseAPI

+ (PKRequest *)requestForGlobalSearchWithQuery:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForSearchInOrganizationWithId:(NSUInteger)orgId query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForSearchInSpaceWithId:(NSUInteger)spaceId query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForSearchInAppWithId:(NSUInteger)appId query:(NSString *)query offset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
