//
//  PKCoreDataMapperFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKCoreDataRepository.h"
#import "NSManagedObject+PKAdditions.h"
#import "NSManagedObjectContext+PKAdditions.h"

@implementation PKCoreDataRepository

@synthesize managedObjectContext = managedObjectContext_;

- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  self = [super init];
  if (self) {
    managedObjectContext_ = nil;
    persistentStoreCoordinator_ = persistentStoreCoordinator;
  }
  return self;
}

+ (id)repositoryWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  return [[[self class] alloc] initWithPersistentStoreCoordinator:persistentStoreCoordinator];
}

#pragma mark - Impl

- (NSManagedObjectContext *)managedObjectContext {
  if (managedObjectContext_ == nil) {
    managedObjectContext_ = [[NSManagedObjectContext alloc] init];
    managedObjectContext_.persistentStoreCoordinator = persistentStoreCoordinator_;
  }
  
  return managedObjectContext_;
}

#pragma mark - PKObjectRepository methods

- (id<PKMappableObject>)objectForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate {
  if (![klass isSubclassOfClass:[NSManagedObject class]]) {
    return nil;
  }
  
  NSEntityDescription *entity = [klass pk_entityInContext:self.managedObjectContext];
  
  NSError *error = nil;
  id obj = [self.managedObjectContext pk_objectForEntity:entity predicate:predicate error:&error];
  if (error != nil) {
    NSLog(@"ERROR: Failed go fetch object: %@, %@", error, [error userInfo]);
  }
  
  return obj;
}

- (id<PKMappableObject>)createObjectForClass:(Class)klass {
  if (![klass isSubclassOfClass:[NSManagedObject class]]) {
    return nil;
  }
  
  NSEntityDescription *entity = [klass pk_entityInContext:self.managedObjectContext];
  id obj = [self.managedObjectContext pk_createObjectForEntity:entity];
  
  return obj;
}

- (void)deleteObjectsForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate {
  if (![klass isSubclassOfClass:[NSManagedObject class]]) {
    return;
  }
  
  NSEntityDescription *entity = [klass pk_entityInContext:self.managedObjectContext];
  
  NSError *error = nil;
  [self.managedObjectContext pk_deleteObjectsForEntity:entity predicate:predicate error:&error];
  if (error != nil) {
    NSLog(@"ERROR: Failed go delete objects: %@, %@", error, [error userInfo]);
  }
}

@end
