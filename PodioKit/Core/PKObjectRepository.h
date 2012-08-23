//
//  PKObjectRepository.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/25/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMappableObject.h"

/** The object repository is an abstraction used to decouple the creation, lookup and deletion of domain objects. 
 Its implementation differs depending on the underlying persistence layer and its interface is only concerned with 
 object class and identity.
 */
@protocol PKObjectRepository <NSObject>

@required

- (id<PKMappableObject>)objectForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate;
- (id<PKMappableObject>)createObjectForClass:(Class)klass;
- (void)deleteObjectsForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate;

@end