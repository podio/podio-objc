//
//  NSManagedObjectContext+Additions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-06-27.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (PKAdditions)

- (id)pk_createObjectForEntityName:(NSString *)entityName;

- (id)pk_createObjectForEntity:(NSEntityDescription *)entity;

- (NSArray *)pk_allObjectsForEntity:(NSEntityDescription *)entity error:(NSError **)error;

- (NSArray *)pk_allObjectsForEntity:(NSEntityDescription *)entity 
                          predicate:(NSPredicate *)predicate 
                              error:(NSError **)error;

- (NSManagedObject *)pk_objectForEntity:(NSEntityDescription *)entity 
                              predicate:(NSPredicate *)predicate 
                                  error:(NSError **)error;

- (BOOL)pk_deleteObjectsForEntity:(NSEntityDescription *)entity 
                        predicate:(NSPredicate *)predicate 
                            error:(NSError **)error;

@end
