//
//  NSArray+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSArray+PKAdditions.h"


@implementation NSArray (PKAdditions)

- (NSArray *)pk_arrayFromObjectsCollectedWithBlock:(id (^)(id obj))block {
  NSMutableArray *mutArray = [[NSMutableArray alloc] initWithCapacity:[self count]];
  
  [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [mutArray addObject:block(obj)];
  }];
  
  NSArray *array = [mutArray copy];
  
  return array;
}

@end
