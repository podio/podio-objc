//
//  POManagedObject.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/7/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <CoreData/CoreData.h>
#import "PKMappableObject.h"
#import "NSManagedObject+ActiveRecord.h"

@interface PKManagedObject : NSManagedObject <PKMappableObject>

@end
