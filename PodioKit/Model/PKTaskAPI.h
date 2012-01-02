//
//  PKTaskAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"

@interface PKTaskAPI : PKBaseAPI

+ (PKRequest *)requestForActiveTasksWithProfileId:(NSUInteger)profileId;
+ (PKRequest *)requestForTaskWithId:(NSUInteger)taskId;

@end
