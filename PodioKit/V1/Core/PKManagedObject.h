//
//  PKManagedObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "PKMappableObject.h"
#import "NSManagedObject+ActiveRecord.h"

@interface PKManagedObject : NSManagedObject <PKMappableObject>

@end
