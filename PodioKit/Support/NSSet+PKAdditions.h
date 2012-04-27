//
//  NSSet+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/7/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSSet (PKAdditions)

- (NSSet *)pk_setFromObjectsCollectedWithBlock:(id (^)(id obj))block;

@end
