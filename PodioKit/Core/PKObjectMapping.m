//
//  PKSyncMap.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-04.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectMapping.h"
#import "NSDate+PKAdditions.h"


static NSString * const kDefaultSequencePropertyName = @"seqIndex";

@implementation PKObjectMapping

@synthesize mappings = mappings_;
@synthesize propertyMappings = propertyMappings_;
@synthesize sequencePropertyName = sequencePropertyName_;

- (id)init {
  self = [super init];
  if (self) {
    mappings_ = [[NSMutableArray alloc] init];
    propertyMappings_ = [[NSMutableDictionary alloc] init];
    sequencePropertyName_ = nil;
    
    [self buildMappings];
  }
  return self;
}


+ (id)mapping {
  return [[self alloc] init];
}

- (void)buildMappings {
  // Subclass should construct mapping
}

+ (BOOL)shouldPerformMappingWithData:(NSDictionary *)data {
  // Subclasses should override to evaluate if the data is mappable
  return YES;
}

- (void)addMapping:(PKAttributeMapping *)mapping {
  [self.mappings addObject:mapping]; // Array to maintain order
}

- (void)hasProperty:(NSString *)property forAttribute:(NSString *)attribute {
  PKValueMapping *mapping = [[PKValueMapping alloc] initWithPropertyName:property attributeName:attribute];

  [self addMapping:mapping];
  [self.propertyMappings setObject:mapping forKey:property]; // Dictionary for fast lookup
  
}

- (void)hasDateProperty:(NSString *)property forAttribute:(NSString *)attribute isUTC:(BOOL)isUTC {
  PKValueMapping *mapping = [[PKValueMapping alloc] initWithPropertyName:property attributeName:attribute];
  mapping.valueType = isUTC ? PKValueTypeUTCDate : PKValueTypeDate;
  
  [self addMapping:mapping];
  [self.propertyMappings setObject:mapping forKey:property]; // Dictionary for fast lookup
  
}

- (void)hasRightsProperty:(NSString *)property forAttribute:(NSString *)attribute {
  [self hasProperty:property forAttribute:attribute block:^id(id attrVal, NSDictionary *objDict, id parent) {
    NSUInteger rightsMask = [PKConstants rightsMaskFromArrayOfStrings:attrVal];
    return @(rightsMask);
  }];
}

- (void)hasProperty:(NSString *)property 
       forAttribute:(NSString *)attribute 
              block:(PKValueMappingBlock)block {
  PKValueMapping *mapping = [[PKValueMapping alloc] initWithPropertyName:property attributeName:attribute block:block];
  [self addMapping:mapping];
  [self.propertyMappings setObject:mapping forKey:property]; // Dictionary for fast lookup
  
}

- (void)hasProperty:(NSString *)property forParentProperty:(NSString *)parentProperty {
  [self hasProperty:property forAttribute:nil block:^id(id attrVal, NSDictionary *objDict, id parent) {
    PKAssert([parent respondsToSelector:NSSelectorFromString(parentProperty)], @"Parent object is missing property '%@'", parentProperty);
    return [parent valueForKey:parentProperty];
  }];
}

- (void)hasRelationship:(NSString *)property 
           forAttribute:(NSString *)attribute 
        inverseProperty:(NSString *)inverseProperty 
          objectMapping:(PKObjectMapping *)objectMapping {
  PKRelationshipMapping *mapping = [PKRelationshipMapping mappingForPropertyName:property 
                                                                   attributeName:attribute 
                                                                 inverseProperty:inverseProperty 
                                                                   objectMapping:objectMapping];
  [self addMapping:mapping];
}

- (void)hasMappingForAttribute:(NSString *)attribute 
                 objectMapping:(PKObjectMapping *)objectMapping 
           scopePredicateBlock:(PKScopePredicateBlock)scopePredicateBlock {
  PKStandaloneMapping *mapping = [PKStandaloneMapping mappingForAttributeName:attribute 
                                                                objectMapping:objectMapping];
  mapping.scopePredicateBlock = scopePredicateBlock;
  [self addMapping:mapping];
}

- (NSString *)sequencePropertyName {
  NSString *name = kDefaultSequencePropertyName;
  if (sequencePropertyName_ != nil) {
    name = sequencePropertyName_;
  }
  
  return [name copy];
}

@end
