//
//  NSManagedObject+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/27/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (PKAdditions)

+ (NSString *)entityName;

+ (NSEntityDescription *)pk_entityInContext:(NSManagedObjectContext *)context;

+ (id)pk_createInContext:(NSManagedObjectContext *)context;

@end
