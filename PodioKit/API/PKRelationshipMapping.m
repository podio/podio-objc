//
//  POSyncCollectionMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKRelationshipMapping.h"
#import "PKObjectMapping.h"

@implementation PKRelationshipMapping

@synthesize objectMapping = objectMapping_;
@synthesize inversePropertyName = inversePropertyName_;
@synthesize inverseScopeAttributeNames = inverseScopeAttributeNames_;

- (id)initWithPropertyName:(NSString *)propertyName 
             attributeName:(NSString *)attributeName 
           inverseProperty:(NSString *)inverseProperty 
inverseScopeAttributeNames:(NSArray *)inverseScopeAttributeNames 
             objectMapping:(PKObjectMapping *)objectMapping {
  self = [super initWithPropertyName:propertyName attributeName:attributeName];
  if (self) {
    self.objectMapping = objectMapping;
    self.inversePropertyName = inverseProperty;
    self.inverseScopeAttributeNames = inverseScopeAttributeNames;
  }
  return self;
}

+ (id)mappingForPropertyName:(NSString *)propertyName 
               attributeName:(NSString *)attributeName 
             inverseProperty:(NSString *)inverseProperty 
  inverseScopeAttributeNames:(NSArray *)inverseScopeAttributeNames 
               objectMapping:(PKObjectMapping *)objectMapping {
  return [[[self alloc] initWithPropertyName:propertyName 
                               attributeName:attributeName 
                             inverseProperty:inverseProperty 
                  inverseScopeAttributeNames:inverseScopeAttributeNames 
                               objectMapping:objectMapping] autorelease];
}

- (void)dealloc {
  [objectMapping_ release];
  [inversePropertyName_ release];
  [inverseScopeAttributeNames_ release];
  [super dealloc];
}

@end
