//
//  PKItemAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"

@interface PKItemAPI : PKBaseAPI

+ (PKRequest *)requestForItemWithId:(NSUInteger)itemId;
+ (PKRequest *)requestForItemsInAppWithId:(NSUInteger)appId filterId:(NSUInteger)filterId offset:(NSUInteger)offset limit:(NSUInteger)limit;
+ (PKRequest *)requestToCreateItemWithAppId:(NSUInteger)appId fields:(NSArray *)fields fileIds:(NSArray *)fileIds;
+ (PKRequest *)requestToUpdateItemFields:(NSArray *)fields itemId:(NSUInteger)itemId;
+ (PKRequest *)requestToUpdateItemWithId:(NSUInteger)itemId fields:(NSArray *)fields fileIds:(NSArray *)fileIds;

@end
