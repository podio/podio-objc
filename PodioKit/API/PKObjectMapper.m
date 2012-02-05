//
//  POMapper.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/31/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKObjectMapper.h"
#import "PKMappableObject.h"
#import "NSArray+PKAdditions.h"
#import "NSString+PKAdditions.h"
#import "NSDictionary+PKAdditions.h"


@interface PKObjectMapper ()

- (void)deleteObjectsForKlass:(Class)klass identityPredicate:(NSPredicate *)identityPredicate scopePredicate:(NSPredicate *)scopePredicate;

@end

@implementation PKObjectMapper

@synthesize mappingProvider = mappingProvider_;
@synthesize repository = repository_;
@synthesize delegate = delegate_;
@synthesize scopePredicate = scopePredicate_;
@synthesize offset = offset_;
@synthesize mapping = mapping_;
@synthesize mappingBlock = mappingBlock_;

- (id)initWithMappingProvider:(PKMappingProvider *)mappingProvider {
  self = [super init];
  if (self) {
    mappingProvider_ = [mappingProvider retain];
    repository_ = nil;
    delegate_ = nil;
    
    scopePredicate_ = nil;
    offset_ = 0;
    mapping_ = nil;
    mappingBlock_ = nil;
  }
  
  return self;
}

- (void)dealloc {
  delegate_ = nil;
  
  [scopePredicate_ release];
  scopePredicate_ = nil;
  
  [mapping_ release];
  mapping_ = nil;
  
  [mappingBlock_ release];
  mappingBlock_ = nil;
  
  [repository_ release];
  repository_ = nil;
  
  [mappingProvider_ release];
  mappingProvider_ = nil;
  
  [super dealloc];
}

#pragma mark - Mapping

- (id)performMappingWithData:(id)data {
  NSAssert(self.repository != nil, @"No data source set.");
  NSAssert(self.mappingProvider != nil, @"No mapping provider set");
  
  NSString *className = NSStringFromClass([self.mapping class]);
  Class klass = [self.mappingProvider mappedClassForMappingClassName:className];
  if (klass == nil) {
    PKLogDebug(@"No object class for mapping class %@, skipping...", className);
    return nil;
  }
  
  // Extract actual data
  id baseValue = data;
  if (self.mapping.mappedDataPathComponents != nil) {
    baseValue = [data pk_objectForPathComponents:self.mapping.mappedDataPathComponents];
  }
  
  id result = nil;
  
  // Map
  if ([baseValue isKindOfClass:[NSArray class]]) {
    // Collection
    
    NSArray *identityPropNames = [klass identityPropertyNames];

    // Collect identitypredicates
    NSMutableArray *identityPredicates = [[NSMutableArray alloc] init];
    NSMutableArray *identityIds = [[NSMutableArray alloc] init];
    
    BOOL shouldRemoveOld = self.offset == 0;
    
    result = [self applyCollectionObjectMapping:self.mapping objectDicts:baseValue parentObject:nil parentRelationshipName:nil scopePredicate:self.scopePredicate useMappingBlock:YES block:^(id obj, NSDictionary *objDict) {
      
      if (shouldRemoveOld) {
        // Need to build identity predicates for deletion

        if ([identityPropNames count] == 1) {
          // Single prop name, collect ids to use in IN() statement in query
          id propValue = [obj valueForKey:[identityPropNames objectAtIndex:0]];
          [identityIds addObject:propValue];
        } else if ([identityPropNames count] > 1) {
          // Multiple prop names, must use seperate identity predicate for each because IN() does not work
          NSArray *propPredicates = [identityPropNames pk_arrayFromObjectsCollectedWithBlock:^id(id propName) {
            id propValue = [obj valueForKey:propName];
            return [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ == %%@", propName], propValue];
          }];
          
          [identityPredicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:propPredicates]];
        } else {
          // No identity prop names, use self as identity
          [identityPredicates addObject:[NSPredicate predicateWithFormat:@"self == %@", obj]];
        }
      }
    }];
    
    // Delete all not in remote collection
    if (shouldRemoveOld) {
      NSPredicate *identityPredicate = nil;
      if ([identityIds count] > 0) {
        NSString *firstPropName = [identityPropNames objectAtIndex:0];
        identityPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ IN %%@", firstPropName], identityIds]; // Use IN, faster
      } else if ([identityPredicates count] > 0) {
        identityPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:identityPredicates]; // Use OR, slower but supports multiple prop names
      }
      
      [self deleteObjectsForKlass:klass identityPredicate:identityPredicate scopePredicate:self.scopePredicate];
    }
    
    [identityIds release];
    [identityPredicates release];
  } else {
    // Single object
    id obj = [self applySingleObjectMapping:self.mapping objectDict:baseValue parentObject:nil parentRelationshipName:nil scopePredicate:self.scopePredicate useMappingBlock:YES];
    
    if (obj != nil) {
      result = obj;
    }
  }
  
  // Notify delegate
  if ([self.delegate respondsToSelector:@selector(objectMapperDidFinishMapping:)]) {
    [self.delegate objectMapperDidFinishMapping:self];
  }
  
  return result;
}

- (id)applySingleObjectMapping:(PKObjectMapping *)mapping objectDict:(NSDictionary *)objectDict parentObject:(id<PKMappableObject>)parentObject parentRelationshipName:(NSString *)parentRelationshipName scopePredicate:(NSPredicate *)scopePredicate useMappingBlock:(BOOL)useMappingBlock {
  // Lookup class
  NSString *className = NSStringFromClass([mapping class]);
  Class klass = [self.mappingProvider mappedClassForMappingClassName:className];
  
  if (klass == nil) {
    PKLogWarn(@"No object class for mapping class %@, skipping...", className);
    return nil;
  }
  
  // Skip this object?
  if (![[mapping class] shouldPerformMappingWithData:objectDict]) {
    PKLogDebug(@"Skipping mapping for class %@ with data %@...", className, objectDict);
    return nil;
  }
  
  NSArray *identityPropNames = [klass identityPropertyNames];
  
  // Build identity predicate
  NSArray *propPredicates = [identityPropNames pk_arrayFromObjectsCollectedWithBlock:^id(id propName) {
    
    id propMapping = [mapping.propertyMappings objectForKey:propName];
    NSAssert(propMapping != nil, @"No mapping for property '%@', unable to determine object identity.", propName);
    NSAssert([propMapping isKindOfClass:[PKValueMapping class]], @"The mapping identity property '%@' is of an unsupported type %@", propMapping, NSStringFromClass([propMapping class]));
    
    // Determine value
    id attributeValue = [objectDict pk_objectForPathComponents:[propMapping attributePathComponents]];
    id propValue = [propMapping evaluateForValue:attributeValue objectDict:objectDict parent:parentObject];
    
    return [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ == %%@", propName], propValue];
  }];
  
  NSMutableArray *predicates = [[NSMutableArray alloc] init];
  
  // Apply scope predicate for top entity
  if (scopePredicate != nil) {
    [predicates addObject:scopePredicate];
  }
  
  if (propPredicates != nil && [propPredicates count] > 0) {
    [predicates addObjectsFromArray:propPredicates];
  }
  
  // Lookup/create object
  id object = nil;
  
  if (propPredicates != nil && [propPredicates count] > 0) {
    NSPredicate *predicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    
    // Check in parent relationship set before going to repository which is potentially slow
    if (parentObject != nil && parentRelationshipName != nil && [parentObject respondsToSelector:NSSelectorFromString(parentRelationshipName)]) {
      NSSet *relationshipSet = [(id)parentObject valueForKey:parentRelationshipName];
      object = [[relationshipSet filteredSetUsingPredicate:predicate] anyObject];
    }
    
    // No match, lookup in repository
    if (object == nil) {
      object = [self.repository objectForClass:klass matchingPredicate:predicate];
    }
  }
    
  [predicates release];
  
  if (object == nil) {
    object = [self.repository createObjectForClass:klass];
    NSAssert(object != nil, @"Failed to create new instance of class '%@'", NSStringFromClass(klass));
  }
  
  // Apply mapping block
  if (useMappingBlock && self.mappingBlock != nil) {
    self.mappingBlock(object);
  }
  
  // Apply mappings
  [mapping.mappings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    // Get attribute value for (possibly) nested attribute path
    PKAttributeMapping *attributeMapping = (PKAttributeMapping *)obj;
    id attributeValue = [objectDict pk_objectForPathComponents:[attributeMapping attributePathComponents]];
    
    [self applyAttributeMapping:attributeMapping attributeValue:attributeValue object:object objectDict:objectDict parentObject:parentObject];
  }];
  
  return object;
}

- (NSArray *)applyCollectionObjectMapping:(PKObjectMapping *)mapping 
                              objectDicts:(NSArray *)objectDicts 
                             parentObject:(id<PKMappableObject>)parentObject 
                   parentRelationshipName:(NSString *)parentRelationshipName 
                           scopePredicate:(NSPredicate *)scopePredicate 
                          useMappingBlock:(BOOL)useMappingBlock 
                                    block:(void (^)(id obj, NSDictionary *objDict))block {
  NSMutableArray *mutObjects = [[NSMutableArray alloc] init];
  
  __block NSUInteger seqIndex = self.offset;
  
  [objectDicts enumerateObjectsUsingBlock:^(id objectDict, NSUInteger idx, BOOL *stop) {
    
    id object = [self applySingleObjectMapping:mapping objectDict:objectDict parentObject:parentObject parentRelationshipName:parentRelationshipName scopePredicate:scopePredicate useMappingBlock:useMappingBlock];
    
    if (object != nil) {
      [mutObjects addObject:object];
      
      // Set sequence property
      if (mapping.sequencePropertyName != nil) {
        NSString *sequenceSetSelectorName = [NSString stringWithFormat:@"set%@:", [mapping.sequencePropertyName pk_stringByCapitalizingFirstCharacter]];
        if ([object respondsToSelector:NSSelectorFromString(sequenceSetSelectorName)]) {
          [object setValue:[NSNumber numberWithUnsignedInteger:seqIndex] forKey:mapping.sequencePropertyName];
        }
      }
      
      ++seqIndex;
      
      block(object, objectDict);
    }
  }];
  
  NSArray *objects = [NSArray arrayWithArray:mutObjects];
  [mutObjects release];
  
  return objects;
}

- (void)applyAttributeMapping:(PKAttributeMapping *)mapping 
               attributeValue:(id)attributeValue 
                       object:(id<PKMappableObject>)object 
                   objectDict:(NSDictionary *)objectDict 
                 parentObject:(id<PKMappableObject>)parentObject {
  
  if (attributeValue == nil) return;
  
  if ([mapping isMemberOfClass:[PKValueMapping class]]) {
    // Single value mapping
    PKValueMapping *valueMapping = (PKValueMapping *)mapping;
    NSString *selectorString = [NSString stringWithFormat:@"set%@:", [valueMapping.propertyName pk_stringByCapitalizingFirstCharacter]];
    
    if ([object respondsToSelector:NSSelectorFromString(selectorString)]) {
      id value = [valueMapping evaluateForValue:attributeValue objectDict:objectDict parent:parentObject];
      [(id)object setValue:value forKey:valueMapping.propertyName];
    } else {
      PKLogDebug(@"No selector for mapping property name '%@'", valueMapping.propertyName);
    }
  }
  else if ([mapping isMemberOfClass:[PKRelationshipMapping class]]) {
    // Relationship
    [self applyRelationshipMapping:(id)mapping attributeValue:attributeValue object:object];
  }
  else if ([mapping isMemberOfClass:[PKStandaloneMapping class]]) {
    // Standalone
    [self applyStandaloneMapping:(id)mapping attributeValue:attributeValue parentObject:object parentDict:objectDict];
  }
  else if ([mapping isMemberOfClass:[PKCompoundMapping class]]) {
    // Compound
    [[(PKCompoundMapping *)mapping mappings] enumerateObjectsUsingBlock:^(id subMapping, NSUInteger idx, BOOL *stop) {
      id subAttributeValue = [attributeValue pk_objectForPathComponents:[subMapping attributePathComponents]];
      [self applyAttributeMapping:subMapping attributeValue:subAttributeValue object:object objectDict:objectDict parentObject:parentObject];
    }];
  }
}

- (id)applyRelationshipMapping:(PKRelationshipMapping *)mapping attributeValue:(id)attributeValue object:(id<PKMappableObject>)object {
  NSAssert(mapping.objectMapping != nil, @"No object mapping set.");
  
  NSString *className = NSStringFromClass([mapping.objectMapping class]);
  Class klass = [self.mappingProvider mappedClassForMappingClassName:className];
  if (klass == nil) {
    PKLogWarn(@"No object class for mapping class %@, skipping...", className);
    return nil;
  }
  
  id result = nil;
  
  // Scope predicate
  NSPredicate *scopePredicate = nil;
  if (mapping.inversePropertyName != nil && mapping.inverseScopeAttributeNames != nil) {
    NSArray *invScopePreds = [mapping.inverseScopeAttributeNames pk_arrayFromObjectsCollectedWithBlock:^id(id invScopeAttrName) {
      NSString *predicateString = [NSString stringWithFormat:@"%@.%@ == %%@", mapping.inversePropertyName, invScopeAttrName];
      return [NSPredicate predicateWithFormat:predicateString, [(id)object valueForKey:invScopeAttrName]];
    }];
    
    scopePredicate = [NSCompoundPredicate andPredicateWithSubpredicates:invScopePreds];
  }
  
  if ([attributeValue isKindOfClass:[NSArray class]]) {
    // One-to-many
    NSMutableArray *resultObjects = [[NSMutableArray alloc] init];
    
    NSArray *identityPropNames = [klass identityPropertyNames];
    
    NSMutableArray *identityPredicates = [[NSMutableArray alloc] init];
    NSMutableArray *identityIds = [[NSMutableArray alloc] init];
    
    [self applyCollectionObjectMapping:mapping.objectMapping objectDicts:attributeValue parentObject:object parentRelationshipName:[mapping propertyName] scopePredicate:scopePredicate useMappingBlock:NO block:^(id subObj, NSDictionary *subObjDict) {
      
      // Build identity predicate
      if ([identityPropNames count] == 1) {
        // Single prop name, collect ids to use in IN() statement in query
        id propValue = [subObj valueForKey:[identityPropNames objectAtIndex:0]];
        [identityIds addObject:propValue];
      } else if ([identityPropNames count] > 1) {
        // Multiple prop names, must use seperate identity predicate for each because IN() does not work
        NSArray *propPredicates = [identityPropNames pk_arrayFromObjectsCollectedWithBlock:^id(id propName) {
          id propValue = [subObj valueForKey:propName];
          return [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ == %%@", propName], propValue];
        }];
        
        [identityPredicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:propPredicates]];
      } else {
        // No identity prop names, use self as identity
        [identityPredicates addObject:[NSPredicate predicateWithFormat:@"self == %@", subObj]];
      }
      
      // Set inverse relationship property
      if (mapping.inversePropertyName != nil) {
        [subObj setValue:object forKey:mapping.inversePropertyName];
      }
      
      [resultObjects addObject:subObj];
    }];
    
    // Combine identity predicates
    NSPredicate *identityPredicate = nil;
    if ([identityIds count] > 0) {
      NSString *firstPropName = [identityPropNames objectAtIndex:0];
      identityPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ IN %%@", firstPropName], identityIds]; // Use IN, faster
    } else if ([identityPredicates count] > 0) {
      identityPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:identityPredicates]; // Use OR, slower but supports multiple prop names
    }
    
    [self deleteObjectsForKlass:klass identityPredicate:identityPredicate scopePredicate:scopePredicate];
    [identityIds release];
    [identityPredicates release];
    
    result = [NSArray arrayWithArray:resultObjects];
    [resultObjects release];
  } else {
    // One-to-one
    id subObj = [self applySingleObjectMapping:mapping.objectMapping objectDict:attributeValue parentObject:object parentRelationshipName:[mapping propertyName] scopePredicate:scopePredicate useMappingBlock:NO];
    
    if (subObj != nil) {
      // Set inverse relationship property
      if (mapping.inversePropertyName != nil) {
        [subObj setValue:object forKey:mapping.inversePropertyName];
      }
      
      result = subObj;
    }
  }
  
  // If there was no inverse property from child -> parent, check if the parent has a property to define the children
  if (mapping.inversePropertyName == nil) {
    NSString *setSelectorName = [NSString stringWithFormat:@"set%@:", [mapping.propertyName pk_stringByCapitalizingFirstCharacter]];
    if ([object respondsToSelector:NSSelectorFromString(setSelectorName)]) {
      [(id)object setValue:result forKey:mapping.propertyName];
    }
  }
  
  return result;
}

- (void)applyStandaloneMapping:(PKStandaloneMapping *)mapping 
                attributeValue:(id)attributeValue 
                  parentObject:(id<PKMappableObject>)parentObject 
                    parentDict:(NSDictionary *)parentDict {
  
  // Scope predicate
  NSPredicate *scopePredicate = nil;
  if (mapping.scopePredicateBlock != nil) {
    scopePredicate = mapping.scopePredicateBlock(parentObject);
  }
  
  if ([attributeValue isKindOfClass:[NSArray class]]) {
    // Collection
    NSString *className = NSStringFromClass([mapping.objectMapping class]);
    Class klass = [self.mappingProvider mappedClassForMappingClassName:className];
    if (klass == nil) {
      PKLogWarn(@"No object class for mapping class %@, skipping...", className);
      return;
    }
    
    NSArray *identityPropNames = [klass identityPropertyNames];
    
    // Collect identities
    NSMutableArray *identityPredicates = [[NSMutableArray alloc] init];
    NSMutableArray *identityIds = [[NSMutableArray alloc] init];
    
    [self applyCollectionObjectMapping:mapping.objectMapping objectDicts:attributeValue parentObject:parentObject parentRelationshipName:nil scopePredicate:scopePredicate useMappingBlock:NO block:^(id obj, NSDictionary *objDict) {
      
      // Build identity predicate
      if ([identityPropNames count] == 1) {
        // Single prop name, collect ids to use in IN() statement in query
        id propValue = [obj valueForKey:[identityPropNames objectAtIndex:0]];
        [identityIds addObject:propValue];
      } else if ([identityPropNames count] > 1) {
        // Multiple prop names, must use seperate identity predicate for each because IN() does not work
        NSArray *propPredicates = [identityPropNames pk_arrayFromObjectsCollectedWithBlock:^id(id propName) {
          id propValue = [obj valueForKey:propName];
          return [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ == %%@", propName], propValue];
        }];
        
        [identityPredicates addObject:[NSCompoundPredicate andPredicateWithSubpredicates:propPredicates]];
      } else {
        // No identity prop names, use self as identity
        [identityPredicates addObject:[NSPredicate predicateWithFormat:@"self == %@", obj]];
      }
      
    }];
    
    // Combine identity predicates
    NSPredicate *identityPredicate = nil;
    if ([identityIds count] > 0) {
      NSString *firstPropName = [identityPropNames objectAtIndex:0];
      identityPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ IN %%@", firstPropName], identityIds]; // Use IN, faster
    } else if ([identityPredicates count] > 0) {
      identityPredicate = [NSCompoundPredicate orPredicateWithSubpredicates:identityPredicates]; // Use OR, slower but supports multiple prop names
    }
    
    [self deleteObjectsForKlass:klass identityPredicate:identityPredicate scopePredicate:scopePredicate];
    
    [identityIds release];
    [identityPredicates release];
  } else {
    // Single
    [self applySingleObjectMapping:mapping.objectMapping objectDict:attributeValue parentObject:parentObject parentRelationshipName:nil scopePredicate:scopePredicate useMappingBlock:NO];
  }
}

- (void)deleteObjectsForKlass:(Class)klass identityPredicate:(NSPredicate *)identityPredicate scopePredicate:(NSPredicate *)scopePredicate {
  // Inverse predicates
  NSPredicate *invIdentityPredicate = nil;
  if (identityPredicate != nil) {
    invIdentityPredicate = [NSCompoundPredicate notPredicateWithSubpredicate:identityPredicate];
  }
  
  // Combine scope with identity predicates
  NSPredicate *deletePredicate = nil;
  if (scopePredicate != nil && invIdentityPredicate != nil) {
    // Both
    NSArray *predicates = [[NSArray alloc] initWithObjects:scopePredicate, invIdentityPredicate, nil];
    deletePredicate = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    [predicates release];
  } else if (scopePredicate != nil) {
    deletePredicate = scopePredicate;
  } else if (invIdentityPredicate != nil) {
    deletePredicate = invIdentityPredicate;
  }
  
  [self.repository deleteObjectsForClass:klass matchingPredicate:deletePredicate];
}

@end
