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

+ (PKRequest *)requestForTaskWithId:(NSUInteger)taskId;
+ (PKRequest *)requestForTasksWithParameters:(NSDictionary *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit;

+ (PKRequest *)requestForMyTasksForUserId:(NSUInteger)userId offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForDelegatedTasksOffset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestForCompletedTasksWithOffset:(NSUInteger)offset limit:(NSUInteger)limit;

@end
