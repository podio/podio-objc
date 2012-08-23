//
//  NSArray+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (PKAdditions)

- (NSArray *)pk_arrayFromObjectsCollectedWithBlock:(id (^)(id obj))block;

@end
