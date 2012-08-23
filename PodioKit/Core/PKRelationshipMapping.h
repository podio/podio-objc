//
//  PKSyncCollectionMapping.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKPropertyMapping.h"


@class PKObjectMapping;

@interface PKRelationshipMapping : PKPropertyMapping {

 @protected
  PKObjectMapping *objectMapping_;       // The object mapping for the target entity
  NSString *inversePropertyName_;        // The name of the target entity's inverse property for this relationship
}

@property (nonatomic, strong) PKObjectMapping *objectMapping;
@property (nonatomic, strong) NSString *inversePropertyName;

- (id)initWithPropertyName:(NSString *)propertyName 
             attributeName:(NSString *)attributeName 
           inverseProperty:(NSString *)inverseProperty 
             objectMapping:(PKObjectMapping *)objectMapping;

+ (id)mappingForPropertyName:(NSString *)propertyName 
               attributeName:(NSString *)attributeName 
             inverseProperty:(NSString *)inverseProperty 
               objectMapping:(PKObjectMapping *)objectMapping;

@end
