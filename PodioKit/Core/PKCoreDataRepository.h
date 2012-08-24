//
//  PKCoreDataMapperFactory.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "PKObjectRepository.h"

@interface PKCoreDataRepository : NSObject <PKObjectRepository> {

 @private
  NSPersistentStoreCoordinator *persistentStoreCoordinator_;
  NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

+ (id)repositoryWithPersistentStoreCoordinator:(NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
