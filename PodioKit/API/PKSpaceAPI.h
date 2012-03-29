//
//  PKSpaceAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKSpaceAPI : PKBaseAPI

+ (PKRequest *)requestToJoinSpaceWithId:(NSUInteger)spaceId;
+ (PKRequest *)requestToAcceptSpaceMemberRequestWithId:(NSUInteger)requestId spaceId:(NSUInteger)spaceId;
+ (PKRequest *)requestToCreateSpaceWithName:(NSString *)name organizationId:(NSUInteger)organizationId;

@end
