//
//  POSyncCollectionMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKPropertyMapping.h"


@class PKObjectMapping;

@interface PKRelationshipMapping : PKPropertyMapping {

 @protected
  PKObjectMapping *objectMapping_;       // The object mapping for the target entity
  NSString *inversePropertyName_;        // The name of the target entity's inverse property for this relationship
  NSArray *inverseScopeAttributeNames_;  // The attributes of the parent entity that defines
                                         // the scope of the target entity of the relationship
}

@property (nonatomic, retain) PKObjectMapping *objectMapping;
@property (nonatomic, retain) NSString *inversePropertyName;
@property (nonatomic, retain) NSArray *inverseScopeAttributeNames;

- (id)initWithPropertyName:(NSString *)propertyName 
             attributeName:(NSString *)attributeName 
           inverseProperty:(NSString *)inverseProperty 
inverseScopeAttributeNames:(NSArray *)inverseScopeAttributeNames 
             objectMapping:(PKObjectMapping *)objectMapping;

+ (id)mappingForPropertyName:(NSString *)propertyName 
               attributeName:(NSString *)attributeName 
             inverseProperty:(NSString *)inverseProperty 
  inverseScopeAttributeNames:(NSArray *)inverseScopeAttributeNames 
               objectMapping:(PKObjectMapping *)objectMapping;

@end
