//
//  PKLiveAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 6/6/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKLiveAPI.h"

@implementation PKLiveAPI

+ (PKRequest *)requestToAcceptLiveWithId:(NSUInteger)liveId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/live/%ld/accept", (unsigned long)liveId]];
}

+ (PKRequest *)requestToDeclineLiveWithId:(NSUInteger)liveId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/live/%ld/decline", (unsigned long)liveId]];
}

@end
