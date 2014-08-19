//
//  PKTWorkspacesAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"
#import "PKTConstants.h"

@interface PKTWorkspacesAPI : PKTBaseAPI

+ (PKTRequest *)requestForWorkspaceWithID:(NSUInteger)workspaceID;

+ (PKTRequest *)requestToCreateWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organization privacy:(PKTWorkspacePrivacy)privacy;

@end
