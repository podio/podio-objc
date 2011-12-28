//
//  POItemAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"

@interface PKItemAPI : PKBaseAPI

+ (PKRequest *)requestForItemWithId:(NSUInteger)itemId;

@end
