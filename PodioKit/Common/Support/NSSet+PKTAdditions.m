//
//  NSSet+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 29/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSSet+PKTAdditions.h"

@implementation NSSet (PKTAdditions)

- (instancetype)pkt_mappedSetWithBlock:(id (^)(id obj))block {
  NSParameterAssert(block);
  
  NSMutableSet *mutSet = [[NSMutableSet alloc] initWithCapacity:[self count]];
  for (id object in self) {
    id mappedObject = block(object);
    if (mappedObject) {
      [mutSet addObject:mappedObject];
    }
  }
  
  return [mutSet copy];
}

- (instancetype)pkt_filteredSetWithBlock:(BOOL (^)(id obj))block {
  NSParameterAssert(block);
  
  return [self pkt_mappedSetWithBlock:^id(id obj) {
    return block(obj) ? obj : nil;
  }];
}

@end
