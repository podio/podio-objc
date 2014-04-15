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

@property (nonatomic, copy) NSArray *propertyNames;

@end

@implementation PKTModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  if (!self) return nil;
  
  [self updateValuesFromDictionary:dictionary];
  
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super init];
  if (!self) return nil;

  for (NSString *propertyName in self.propertyNames) {
    id value = [coder decodeObjectForKey:propertyName];
    [self setValue:value forKey:propertyName];
  }
  
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  for (NSString *propertyName in self.propertyNames) {
    id value = [self valueForKey:propertyName];
    [coder encodeObject:value forKey:propertyName];
  }
}

#pragma mark - Properties

- (NSArray *)propertyNames {
  if (!_propertyNames) {
    _propertyNames = [self lookupPropertyNames];
  }
  
  return _propertyNames;
}

#pragma mark - Public

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return nil;
}

#pragma mark - Mapping

- (void)updateValuesFromDictionary:(NSDictionary *)dictionary {
  for (NSString *propertyName in self.propertyNames) {
    // Should this property be mapped?
    NSDictionary *keyPathMapping = [[self class] dictionaryKeyPathsForPropertyNames];
    NSString *keyPath = [keyPathMapping objectForKey:propertyName];
    if (!keyPath) {
      keyPath = propertyName;
    }
    
    id value = [dictionary valueForKeyPath:keyPath];
    if (value) {
      // Is there is a value transformer for this property?
      NSValueTransformer *transformer = [[self class] valueTransformerForKey:propertyName];
      if (transformer)  {
        value = [transformer transformedValue:value];
      }
      
      if (value == NSNull.null) {
        // NSNull should be treated as nil
        value = nil;
      }
      
      [self setValue:value forKey:propertyName];
    }
  }
}

- (NSDictionary *)dictionaryRepresentation {
  // TODO: Serialize object into JSON again
  return nil;
}

#pragma mark - Introspection

- (NSArray *)lookupPropertyNames {
  NSArray *propertyNames = objc_getAssociatedObject([self class], _cmd);
  if (propertyNames) {
    return propertyNames;
  }

  NSMutableArray *mutPropertyNames = [NSMutableArray array];
  
  // Find all properties, backed by an ivar and with a KVC-compliant name in this class and any superclass
  Class klass = [self class];
  while (klass != [NSObject class]) {
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList([self class], &propertyCount);
    
    for (int i = 0; i < propertyCount; ++i) {
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
    
    klass = [klass superclass];
  }
  
  propertyNames = [mutPropertyNames copy];
  objc_setAssociatedObject([self class], _cmd, propertyNames, OBJC_ASSOCIATION_COPY_NONATOMIC);
  
  return propertyNames;
}

#pragma mark - Value transformation

+ (NSValueTransformer *)valueTransformerForKey:(NSString *)key {
  NSString *transformerSelectorName = [key stringByAppendingString:@"ValueTransformer"];
  NSValueTransformer *transformer = [self pkt_valueByPerformingSelectorWithName:transformerSelectorName];
  
  return transformer;
}

@end
