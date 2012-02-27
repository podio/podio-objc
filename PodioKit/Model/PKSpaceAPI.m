//
//  PKSpaceAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/27/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKSpaceAPI.h"

@implementation PKSpaceAPI

+ (PKRequest *)requestToJoinSpaceWithId:(NSUInteger)spaceId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/space/%d/join", spaceId] method:PKAPIRequestMethodPOST];
}

@end
