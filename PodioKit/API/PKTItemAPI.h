//
//  PKTItemAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTItemAPI : PKTBaseAPI

+ (PKTRequest *)requestForItemWithID:(NSUInteger)itemID;

+ (PKTRequest *)requestToCreateItemInAppWithID:(NSUInteger)appID fields:(NSDictionary *)fields files:(NSArray *)files tags:(NSArray *)tags;

+ (PKTRequest *)requestToUpdateItemWithID:(NSUInteger)itemID fields:(NSDictionary *)fields files:(NSArray *)files tags:(NSArray *)tags;

@end
