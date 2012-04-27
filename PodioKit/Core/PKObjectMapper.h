//
//  PKMapper.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKMappingProvider.h"
#import "PKMappableObject.h"
#import "PKObjectRepository.h"
#import "PKObjectMapping.h"

typedef void (^PKCustomMappingBlock)(id obj);

@class PKObjectMapper;
@class PKObjectMapping;

@protocol PKObjectMapperDelegate <NSObject>

@optional

- (void)objectMapperWillBeginMapping:(PKObjectMapper *)objectMapper;
- (void)objectMapperDidFinishMapping:(PKObjectMapper *)objectMapper;

@end

@interface PKObjectMapper : NSObject {
  
 @private
  PKMappingProvider *mappingProvider_;
  
  id<PKObjectRepository> repository_;
  id<PKObjectMapperDelegate> __unsafe_unretained delegate_;
  
  NSPredicate *scopePredicate_;
  NSUInteger offset_;
  
  PKObjectMapping *mapping_;
  PKCustomMappingBlock mappingBlock_;
  
  NSDateFormatter *dateFormatter_;
}

@property (strong, readonly) PKMappingProvider *provider;
@property (strong, readonly) id<PKObjectRepository> repository; // NOTE! The repository is retained throught the lifecycle of this mapper
@property (unsafe_unretained) id<PKObjectMapperDelegate> delegate;
@property (strong) NSPredicate *scopePredicate;
@property NSUInteger offset;
@property (strong) PKObjectMapping *mapping;
@property (copy) PKCustomMappingBlock mappingBlock;

- (id)initWithProvider:(PKMappingProvider *)provider repository:(id<PKObjectRepository>)repository;

- (id)performMappingWithData:(id)data;

- (id)applySingleObjectMapping:(PKObjectMapping *)mapping 
                    objectDict:(NSDictionary *)objectDict 
                  parentObject:(id<PKMappableObject>)parentObject 
        parentRelationshipName:(NSString *)parentRelationshipName 
                scopePredicate:(NSPredicate *)scopePredicate 
               useMappingBlock:(BOOL)useMappingBlock;

- (NSArray *)applyCollectionObjectMapping:(PKObjectMapping *)mapping 
                              objectDicts:(NSArray *)objectDicts 
                             parentObject:(id<PKMappableObject>)parentObject 
                   parentRelationshipName:(NSString *)parentRelationshipName 
                           scopePredicate:(NSPredicate *)scopePredicate 
                          useMappingBlock:(BOOL)useMappingBlock 
                                    block:(void (^)(id obj, NSDictionary *objDict))block;

- (void)applyAttributeMapping:(PKAttributeMapping *)mapping 
               attributeValue:(id)attributeValue 
                       object:(id<PKMappableObject>)object 
                   objectDict:(NSDictionary *)objectDict 
                 parentObject:(id<PKMappableObject>)parentObject;

- (id)applyRelationshipMapping:(PKRelationshipMapping *)mapping 
                attributeValue:(id)attributeValue 
                        object:(id<PKMappableObject>)object;

- (void)applyStandaloneMapping:(PKStandaloneMapping *)mapping 
                attributeValue:(id)attributeValue 
                  parentObject:(id<PKMappableObject>)parentObject 
                    parentDict:(NSDictionary *)parentDict;

@end
