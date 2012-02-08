//
//  NSManagedObject+ActiveRecord.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/31/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (ActiveRecord)

+ (id)findWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
+ (id)findWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context error:(NSError **)error;

+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context;
+ (NSArray *)findAllInContext:(NSManagedObjectContext *)context error:(NSError **)error;

+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
+ (NSArray *)findAllWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context error:(NSError **)error;

+ (void)deleteWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context;
+ (BOOL)deleteWithPredicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context error:(NSError **)error;

+ (id)createInContext:(NSManagedObjectContext *)context;

- (BOOL)save;
- (BOOL)saveWithError:(NSError **)error;

- (void)deleteObject;
+ (void)deleteAllInContext:(NSManagedObjectContext *)context;

@end
