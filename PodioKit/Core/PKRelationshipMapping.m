//
//  PKSyncCollectionMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKRelationshipMapping.h"
#import "PKObjectMapping.h"

@implementation PKRelationshipMapping

@synthesize objectMapping = objectMapping_;
@synthesize inversePropertyName = inversePropertyName_;

- (id)initWithPropertyName:(NSString *)propertyName 
             attributeName:(NSString *)attributeName 
           inverseProperty:(NSString *)inverseProperty 
             objectMapping:(PKObjectMapping *)objectMapping {
  self = [super initWithPropertyName:propertyName attributeName:attributeName];
  if (self) {
    self.objectMapping = objectMapping;
    self.inversePropertyName = inverseProperty;
  }
  return self;
}

+ (id)mappingForPropertyName:(NSString *)propertyName 
               attributeName:(NSString *)attributeName 
             inverseProperty:(NSString *)inverseProperty 
               objectMapping:(PKObjectMapping *)objectMapping {
  return [[self alloc] initWithPropertyName:propertyName 
                               attributeName:attributeName 
                             inverseProperty:inverseProperty 
                               objectMapping:objectMapping];
}


@end
