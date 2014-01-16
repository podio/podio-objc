//
//  NSManagedObjectContext+Additions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-06-27.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSManagedObjectContext+PKAdditions.h"


@implementation NSManagedObjectContext (PKAdditions)

- (id)pk_createObjectForEntityName:(NSString *)entityName {
  return [NSEntityDescription insertNewObjectForEntityForName:entityName inManagedObjectContext:self];
}

- (id)pk_createObjectForEntity:(NSEntityDescription *)entity {
  return [self pk_createObjectForEntityName:[entity name]];
}

- (NSArray *)pk_allObjectsForEntity:(NSEntityDescription *)entity error:(NSError **)error {
  return [self pk_allObjectsForEntity:entity predicate:nil error:error];
}

- (NSArray *)pk_allObjectsForEntity:(NSEntityDescription *)entity 
                          predicate:(NSPredicate *)predicate 
                              error:(NSError **)error {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:entity];
  
  if (predicate != nil) {
    [request setPredicate:predicate];
  }
  
  NSArray *result = [self executeFetchRequest:request error:error];
  
  return result;
}

- (NSManagedObject *)pk_objectForEntity:(NSEntityDescription *)entity 
                              predicate:(NSPredicate *)predicate 
                                  error:(NSError **)error {
  NSArray *result = [self pk_allObjectsForEntity:entity predicate:predicate error:error];
  
  NSManagedObject *obj = nil;
  if ([result count] > 0) {
    obj =  [result objectAtIndex:0];
  }
  
  return obj;
}

- (BOOL)pk_deleteObjectsForEntity:(NSEntityDescription *)entity 
                        predicate:(NSPredicate *)predicate 
                            error:(NSError **)error {
  NSArray *result = [self pk_allObjectsForEntity:entity predicate:predicate error:error];
  
  [result enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    [self deleteObject:obj];
  }];
  
  return result != nil;
}

@end
