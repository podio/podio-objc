//
//  PKTModel.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "PKTModel.h"
#import "NSObject+PKTIntrospection.h"

@interface PKTModel ()

@property (nonatomic, copy, readonly) NSArray *codablePropertyNames;

@end

@implementation PKTModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (!self) return nil;
  
  [self updateFromDictionary:dictionary];
  
  return self;
}

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if (!self) return nil;

  for (NSString *propertyName in self.codablePropertyNames) {
    id value = [coder decodeObjectForKey:propertyName];
    [self setValue:value forKey:propertyName];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  for (NSString *propertyName in self.codablePropertyNames) {
    id value = [self valueForKey:propertyName];
    [coder encodeObject:value forKey:propertyName];
  }
}

#pragma mark - NSCopying

- (id)copyWithZone:(NSZone *)zone {
  id copy = [[[self class] alloc] init];
  
  for (NSString *key in [self codablePropertyNames]) {
    id value = [self valueForKey:key];
    [copy setValue:value forKey:key];
  }
  
  return copy;
}

#pragma mark - Public

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return nil;
}

#pragma mark - Mapping

+ (NSDictionary *)dictionaryKeyPathsForPropertyNamesForClassAndSuperClasses {
  NSMutableDictionary *keyPathsMapping = [NSMutableDictionary new];
  
  Class klass = self;
  while (klass != [PKTModel class]) {
    NSDictionary *klassKeyPaths = [klass dictionaryKeyPathsForPropertyNames];
    if (klass) {
      [keyPathsMapping addEntriesFromDictionary:klassKeyPaths];
    }
    
    klass = [klass superclass];
  }
  
  return [keyPathsMapping copy];
}

- (void)updateFromDictionary:(NSDictionary *)dictionary {
  NSDictionary *keyPathMapping = [[self class] dictionaryKeyPathsForPropertyNamesForClassAndSuperClasses];
  
  for (NSString *propertyName in self.codablePropertyNames) {
    // Should this property be mapped?
    NSString *keyPath = [keyPathMapping objectForKey:propertyName];
    if (!keyPath) {
      keyPath = propertyName;
    }
    
    id value = [dictionary valueForKeyPath:keyPath];
    if (value) {
      if (value == NSNull.null) {
        // NSNull should be treated as nil
        value = nil;
      } else {
        // Is there is a value transformer for this property?
        NSValueTransformer *transformer = [[self class] valueTransformerForKey:propertyName dictionary:dictionary];
        if (transformer)  {
          value = [transformer transformedValue:value];
        }
      }
      
      [self setValue:value forKey:propertyName];
    }
  }
}

- (void)setNilValueForKey:(NSString *)key {
  [self setValue:@0 forKey:key];
}

#pragma mark - Introspection

+ (NSArray *)codablePropertyNames {
  unsigned int propertyCount;
  objc_property_t *properties = class_copyPropertyList(self, &propertyCount);
  
  NSMutableArray *mutPropertyNames = [NSMutableArray arrayWithCapacity:propertyCount];
  
  for (int i = 0; i < propertyCount; ++i) {
    // Find all properties, backed by an ivar and with a KVC-compliant name
    objc_property_t property = properties[i];
    const char *name = property_getName(property);
    NSString *propertyName = @(name);
    
    // Check if there is a backing ivar
    char *ivar = property_copyAttributeValue(property, "V");
    if (ivar) {
      // Check if ivar has KVC-compliant name, i.e. either propertyName or _propertyName
      NSString *ivarName = @(ivar);
      if ([ivarName isEqualToString:propertyName] ||
          [ivarName isEqualToString:[@"_" stringByAppendingString:propertyName]]) {
        // setValue:forKey: will work
        [mutPropertyNames addObject:propertyName];
      }
      
      free(ivar);
    }
  }
  
  free(properties);
  
  return [mutPropertyNames copy];
}

- (NSArray *)codablePropertyNames {
  NSArray *propertyNames = objc_getAssociatedObject([self class], _cmd);
  if (propertyNames) {
    return propertyNames;
  }

  NSMutableArray *mutPropertyNames = [NSMutableArray array];

  Class klass = [self class];
  while (klass != [NSObject class]) {
    NSArray *classPropertyNames = [klass codablePropertyNames];
    [mutPropertyNames addObjectsFromArray:classPropertyNames];
    
    klass = [klass superclass];
  }
  
  propertyNames = [mutPropertyNames copy];
  objc_setAssociatedObject([self class], _cmd, propertyNames, OBJC_ASSOCIATION_COPY);
  
  return propertyNames;
}

#pragma mark - Value transformation

+ (NSValueTransformer *)valueTransformerForKey:(NSString *)key dictionary:(NSDictionary *)dictionary {
  // Try the <propertyName>ValueTransformerWithDictionary: selector
  NSString *transformerSelectorName = [key stringByAppendingString:@"ValueTransformerWithDictionary:"];
  NSValueTransformer *transformer = [self pkt_valueByPerformingSelectorWithName:transformerSelectorName withObject:dictionary];
  
  // Try the <propertyName>ValueTransformer selector
  if (!transformer) {
    transformerSelectorName = [key stringByAppendingString:@"ValueTransformer"];
    transformer = [self pkt_valueByPerformingSelectorWithName:transformerSelectorName];
  }
  
  return transformer;
}

@end
