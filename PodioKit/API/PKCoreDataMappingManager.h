//
//  PKCoreDataMappingManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/14/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "PKMappingManager.h"
#import "PKObjectMapper.h"
#import "PKMappingProvider.h"


@interface PKCoreDataMappingManager : PKMappingManager <PKObjectMapperDelegate> {

 @private
  NSManagedObjectContext *managedObjectContext_;
}

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)managedObjectContext 
                   mappingProvider:(PKMappingProvider *)mappingProvider;

@end
