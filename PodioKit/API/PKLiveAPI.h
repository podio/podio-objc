//
//  PKLiveAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 6/6/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKLiveAPI : PKBaseAPI

+ (PKRequest *)requestToAcceptLiveWithId:(NSUInteger)liveId;
+ (PKRequest *)requestToDeclineLiveWithId:(NSUInteger)liveId;

@end
