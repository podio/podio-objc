//
//  PKAppAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/15/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKAppAPI : PKBaseAPI

+ (PKRequest *)requestForAppWithId:(NSUInteger)appId;
+ (PKRequest *)requestToInstallAppWithId:(NSUInteger)appId spaceId:(NSUInteger)spaceId;
+ (PKRequest *)requestForAppsInSpaceWithId:(NSUInteger)spaceId;
+ (PKRequest *)requestForTopAppsWithLimit:(NSUInteger)limit;

@end
