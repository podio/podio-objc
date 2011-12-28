//
//  POSyncMap.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKValueMapping.h"
#import "PKRelationshipMapping.h"
#import "PKCompoundMapping.h"
#import "PKStandaloneMapping.h"


@interface PKObjectMapping : NSObject {

 @private
  NSMutableArray *mappings_;
  NSMutableDictionary *propertyMappings_;
  NSMutableArray *mappedDataPathComponents_;
  NSString *sequencePropertyName_;
}

@property (nonatomic, retain) NSMutableArray *mappings;
@property (nonatomic, retain) NSMutableDictionary *propertyMappings;
@property (nonatomic, retain) NSMutableArray *mappedDataPathComponents;
@property (nonatomic, copy) NSString *sequencePropertyName;

+ (id)mapping;

- (void)buildMappings;

+ (BOOL)shouldPerformMappingWithData:(NSDictionary *)data;

- (void)addMapping:(PKAttributeMapping *)mapping;

- (void)hasProperty:(NSString *)property forAttribute:(NSString *)attribute;

- (void)hasProperty:(NSString *)property 
       forAttribute:(NSString *)attribute 
              block:(PKValueMappingBlock)block;

- (void)hasProperty:(NSString *)property forParentProperty:(NSString *)parentProperty;

- (void)hasDateProperty:(NSString *)property forAttribute:(NSString *)attribute isUTC:(BOOL)isUTC;

- (void)hasRelationship:(NSString *)property 
           forAttribute:(NSString *)attribute 
        inverseProperty:(NSString *)inverseProperty 
 inverseScopeProperties:(NSArray *)inverseScopeProperties 
          objectMapping:(PKObjectMapping *)objectMapping;

- (void)hasMappingForAttribute:(NSString *)attribute 
                 objectMapping:(PKObjectMapping *)objectMapping 
           scopePredicateBlock:(POScopePredicateBlock)scopePredicateBlock;

@end
