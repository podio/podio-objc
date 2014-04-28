//
//  PKTItemField.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemField.h"
#import "PKTItemFieldValue.h"
#import "NSValueTransformer+PKTTransformers.h"

@interface PKTItemField ()

@property (nonatomic, strong) NSMutableArray *fieldValues;

@end

@implementation PKTItemField

#pragma mark - Properties

- (NSArray *)values {
  return [self.fieldValues copy];
}

- (NSMutableArray *)fieldValues {
  if (!_fieldValues) {
    _fieldValues = [NSMutableArray new];
  }
  
  return _fieldValues;
}

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"fieldID" : @"field_id",
           @"externalID" : @"external_id",
           @"type" : @"type",
           @"fieldValues" : @"values",
           };
}

+ (NSValueTransformer *)typeValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
    @"title" : @(PKTAppFieldTypeTitle),
    @"text" : @(PKTAppFieldTypeText),
    @"number" : @(PKTAppFieldTypeNumber),
    @"image" : @(PKTAppFieldTypeImage),
    @"date" : @(PKTAppFieldTypeDate),
    @"app" : @(PKTAppFieldTypeApp),
    @"contact" : @(PKTAppFieldTypeContact),
    @"money" : @(PKTAppFieldTypeMoney),
    @"progress" : @(PKTAppFieldTypeProgress),
    @"location" : @(PKTAppFieldTypeLocation),
    @"duration" : @(PKTAppFieldTypeDuration),
    @"embed" : @(PKTAppFieldTypeEmbed),
    @"calculation" : @(PKTAppFieldTypeCalculation),
    @"category" : @(PKTAppFieldTypeCategory),
  }];
}

+ (NSValueTransformer *)fieldValuesValueTransformerWithDictionary:(NSDictionary *)dictionary {
  // Get the app field type
  NSString *typeString = dictionary[@"type"];
  PKTAppFieldType type = [[[self typeValueTransformer] transformedValue:typeString] unsignedIntegerValue];
  
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSArray *values) {
    NSMutableArray *fieldValues = [NSMutableArray arrayWithCapacity:[values count]];
    
    for (id value in values) {
      PKTItemFieldValue *fieldValue = [PKTItemFieldValue valueWithType:type valueDictionary:value];
      [fieldValues addObject:fieldValue];
    }
    
    return fieldValues;
  }];
}

#pragma mark - Public

- (id)valueAtIndex:(NSUInteger)index {
  return self.fieldValues[index];
}

- (id)firstValue {
  return [self.fieldValues firstObject];
}

- (void)setValues:(NSArray *)values {
  NSParameterAssert(values);
  self.fieldValues = [values mutableCopy];
}

- (void)setFirstValue:(id)value {
  NSParameterAssert(value);
  self.fieldValues[0] = value;
}

- (void)addValue:(id)value {
  NSParameterAssert(value);
  [self.fieldValues addObject:value];
}

- (void)removeValue:(id)value {
  NSParameterAssert(value);
  [self.fieldValues removeObject:value];
}

- (void)removeValueAtIndex:(NSUInteger)index {
  [self.fieldValues removeObjectAtIndex:index];
}

- (NSArray *)preparedValues {
  id value = nil;
  
  NSMutableArray *fieldValues = [NSMutableArray new];
  for (PKTItemFieldValue *value in self.fieldValues) {
    NSDictionary *valueDict = value.valueDictionary;
    if (valueDict) {
      [fieldValues addObject:valueDict];
    }
  }
  
  return value;
}

@end
