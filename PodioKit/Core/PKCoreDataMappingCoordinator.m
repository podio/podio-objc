//
//  PKCoreDataMappingCoordinator.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKCoreDataMappingCoordinator.h"
#import "PKCoreDataRepository.h"
#import "NSArray+PKAdditions.h"
#import "NSManagedObjectContext+PKAdditions.h"

@implementation PKCoreDataMappingCoordinator

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext 
                   mappingProvider:(PKMappingProvider *)mappingProvider {
  self = [super initWithMappingProvider:mappingProvider];
  if (self) {
    _managedObjectContext = managedObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mappingContextDidSave:)
                                                 name:NSManagedObjectContextDidSaveNotification 
                                               object:nil];
  }
  
  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (PKObjectMapper *)objectMapper {
  PKAssert(self.mappingProvider != nil, @"No mapping provider set.");
  
  // Create background worker context for mapping
  NSManagedObjectContext *mapperContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
  mapperContext.persistentStoreCoordinator = self.managedObjectContext.persistentStoreCoordinator;
  
  PKCoreDataRepository *repository = [[PKCoreDataRepository alloc] initWithManagedObjectContext:mapperContext];
  
  PKObjectMapper *mapper = [[PKObjectMapper alloc] initWithProvider:self.mappingProvider repository:repository];
  mapper.delegate = self;
  
  return mapper;
}

- (void)mappingContextDidSave:(NSNotification *)notification {
  // Ignore save notifications from main context
  NSManagedObjectContext *savedContext = notification.object;
  if (savedContext == self.managedObjectContext ||
      savedContext.concurrencyType != NSPrivateQueueConcurrencyType) return;
  
  // Merge changes from background context to main context
  NSManagedObjectContext *context = self.managedObjectContext;
  
  [context performBlockAndWait:^{
    // Turn updated objects into faults
    NSSet *updatedObjectIds = [[notification.userInfo objectForKey:@"updated"] valueForKey:@"objectID"];
    [updatedObjectIds enumerateObjectsUsingBlock:^(id objectID, BOOL *stop) {
      id managedObject = [context objectRegisteredForID:objectID];
      if (managedObject) {
        [context refreshObject:managedObject mergeChanges:YES];
      }
    }];
    
    [context mergeChangesFromContextDidSaveNotification:notification];
  }];
}

#pragma mark - PKObjectMapperDelegate methods

- (void)objectMapperDidFinishMapping:(PKObjectMapper *)objectMapper {
  PKObjectMapper *mapper = (PKObjectMapper *)objectMapper;
  if ([mapper.repository isKindOfClass:[PKCoreDataRepository class]]) {
    NSManagedObjectContext *context = [(PKCoreDataRepository *)mapper.repository managedObjectContext];
    
    // Save worker context
    [context performBlockAndWait:^{
      NSError *error = nil;

      if (![context save:&error]) {
        PKLogError(@"ERROR: Failed to mapper context: %@", error);
      }
    }];
  }
}


@end
