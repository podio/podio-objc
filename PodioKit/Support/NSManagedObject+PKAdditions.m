//
//  NSManagedObject+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSManagedObject+PKAdditions.h"

@implementation NSManagedObject (PKAdditions)

+ (NSString *)entityName {
  // Default is class name
  return NSStringFromClass([self class]);
}

+ (NSEntityDescription *)pk_entityInContext:(NSManagedObjectContext *)context {
  return [NSEntityDescription entityForName:[self entityName] inManagedObjectContext:context];
}

+ (id)pk_createInContext:(NSManagedObjectContext *)context {
  return [[self alloc] initWithEntity:[self pk_entityInContext:context] insertIntoManagedObjectContext:context];
}

@end
