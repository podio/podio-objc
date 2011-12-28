//
//  NSManagedObject+ActiveRecord.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/31/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "NSManagedObject+ActiveRecord.h"
#import "NSManagedObject+PKAdditions.h"

@implementation NSManagedObject (ActiveRecord)

+ (id)findWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context {
  return [self findWithPredicate:predicate context:context error:NULL];
}

+ (id)findWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context error:(NSError **)error {
  NSArray *result = [self findAllWithPredicate:predicate context:context error:error];
  
  id obj = nil;
  if ([result count] > 0) {
    obj = [result objectAtIndex:0];
  }
  
  return obj;
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context {
  return [self findAllWithPredicate:nil context:context];
}

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context error:(NSError **)error {
  return [self findAllWithPredicate:nil context:context error:error];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context {
  return [self findAllWithPredicate:predicate context:context error:NULL];
}

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context error:(NSError **)error {
  NSFetchRequest *request = [[NSFetchRequest alloc] init];
  [request setEntity:[self pk_entityInContext:context]];
  
  if (predicate != nil) {
    [request setPredicate:predicate];
  }
  
  NSArray *result = [context executeFetchRequest:request error:error];
  [request release];
  
  return result;
}

+ (void)deleteWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context {
  NSArray *objects = [self findAllWithPredicate:predicate context:context];
  
  if (objects != nil && [objects count] > 0) {
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [context deleteObject:obj];
    }];
  }
}

+ (BOOL)deleteWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context error:(NSError **)error {
  NSArray *objects = [self findAllWithPredicate:predicate context:context error:error];
  
  if (objects != nil && [objects count] > 0) {
    [objects enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
      [context deleteObject:obj];
    }];
  }
  
  return error == NULL || *error == nil;
}

+ (id)createInContext:(NSManagedObjectContext *)context {
  NSString *entityName = [self respondsToSelector:@selector(entityName)] ? [self entityName] : NSStringFromClass(self);
  id obj = [[self alloc] initWithEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context] insertIntoManagedObjectContext:context];
  
  return [obj autorelease];
}

- (BOOL)save {
  return [self saveWithError:NULL];
}

- (BOOL)saveWithError:(NSError **)error {
  return [self.managedObjectContext save:error];
}

- (void)deleteObject {
  [self.managedObjectContext deleteObject:self];
}

@end
