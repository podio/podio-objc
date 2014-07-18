//
//  PKTAppsAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 03/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTAppsAPI : PKTBaseAPI

+ (PKTRequest *)requestForAppWithID:(NSUInteger)appID;
+ (PKTRequest *)requestForAppsInWorkspaceWithID:(NSUInteger)spaceID;
@end
