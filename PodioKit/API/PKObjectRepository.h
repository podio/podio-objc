//
//  PKObjectRepository.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/25/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMappableObject.h"

@protocol PKObjectRepository <NSObject>

@required

- (id<PKMappableObject>)objectForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate;
- (id<PKMappableObject>)createObjectForClass:(Class)klass;
- (void)deleteObjectsForClass:(Class)klass matchingPredicate:(NSPredicate *)predicate;

@end