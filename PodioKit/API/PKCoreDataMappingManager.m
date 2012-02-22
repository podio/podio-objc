//
//  PKCoreDataMappingManager.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/14/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKCoreDataMappingManager.h"
#import "PKCoreDataRepository.h"

@interface PKCoreDataMappingManager ()

- (void)mappingContextDidSave:(NSNotification *)notification;

@end

@implementation PKCoreDataMappingManager

@synthesize managedObjectContext = managedObjectContext_;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext 
                   mappingProvider:(PKMappingProvider *)mappingProvider {
  self = [super initWithMappingProvider:mappingProvider];
  if (self) {
    managedObjectContext_ = managedObjectContext;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mappingContextDidSave:) 
                                                 name:NSManagedObjectContextDidSaveNotification 
                                               object:nil];
  }
  
  return self;
}


- (PKObjectMapper *)objectMapper {
  NSAssert(self.mappingProvider != nil, @"No mapping provider set.");
  
  PKObjectMapper *mapper = [[PKObjectMapper alloc] initWithMappingProvider:self.mappingProvider];
  mapper.delegate = self;
  
  PKCoreDataRepository *repository = [[PKCoreDataRepository alloc] initWithPersistentStoreCoordinator:self.managedObjectContext.persistentStoreCoordinator];
  mapper.repository = repository;
  
  return mapper;
}

- (void)mappingContextDidSave:(NSNotification *)notification {
  NSManagedObjectContext *savedContext = notification.object;
  
  // Only merge from other contexts
  if (savedContext == self.managedObjectContext) {
    return;
  }
  
  if ([NSThread isMainThread]) {
    // Merge changes on main thread
    [self.managedObjectContext mergeChangesFromContextDidSaveNotification:notification];
  } else {
    // Not main thread, perform on main thread
    [self performSelectorOnMainThread:@selector(mappingContextDidSave:) withObject:notification waitUntilDone:NO];
  }
}

#pragma mark - POObjectMapperDelegate methods

- (void)objectMapperDidFinishMapping:(PKObjectMapper *)objectMapper {
  PKObjectMapper *mapper = (PKObjectMapper *)objectMapper;
  if ([mapper.repository isKindOfClass:[PKCoreDataRepository class]]) {
    NSManagedObjectContext *context = [(PKCoreDataRepository *)mapper.repository managedObjectContext];
    
    // Save context
    NSError *error = nil;
    if (![context save:&error]) {
      PKLogError(@"ERROR: Failed to save mapper context: %@, %@", error, [error userInfo]);
    }
  }
}


@end
