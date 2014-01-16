//
//  PKDefaultObjectFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/12/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKDefaultObjectRepository.h"

@implementation PKDefaultObjectRepository

+ (id)repository {
  return [[self alloc] init];
}

- (id<PKMappableObject>)objectForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate {
  return [self createObjectForClass:klass];
}

- (id<PKMappableObject>)createObjectForClass:(Class)klass {
  // Simplest possible instantiation
  return [[klass alloc] init];
}

- (void)deleteObjectsForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate {
  // Do nothing
}

@end
