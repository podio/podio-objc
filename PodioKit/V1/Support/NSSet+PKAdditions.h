//
//  NSSet+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (PKAdditions)

- (NSSet *)pk_setFromObjectsCollectedWithBlock:(id (^)(id obj))block;

@end
