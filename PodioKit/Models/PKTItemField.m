//
//  PKTItemField.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemField.h"
#import "PKTItemFieldValue.h"
#import "PKTBasicItemFieldValue.h"
#import "PKTDateItemFieldValue.h"
#import "PKTMoneyItemFieldValue.h"
#import "PKTEmbedItemFieldValue.h"
#import "PKTFileItemFieldValue.h"
#import "PKTAppItemFieldValue.h"
#import "PKTProfileItemFieldValue.h"
#import "PKTCalculationItemFieldValue.h"
#import "PKTCategoryItemFieldValue.h"
#import "PKTFile.h"
#import "NSValueTransformer+PKTTransformers.h"

@interface PKTItemField ()

@property (nonatomic, assign) NSUInteger fieldID;
@property (nonatomic, copy) NSString *externalID;
@property (nonatomic, assign) PKTAppFieldType type;
@property (nonatomic, strong) NSMutableArray *fieldValues;

@end

@implementation PKTItemField

@synthesize fieldID = _fieldID;
@synthesize externalID = _externalID;
@synthesize type = _type;

- (instancetype)initWithAppField:(PKTAppField *)appField values:(NSArray *)values {
  self = [super init];
  if (!self) return nil;
  
  _fieldID = appField.fieldID;
  _externalID = [appField.externalID copy];
  _type = appField.type;
  _fieldValues = [[self class] mutableFieldValuesForValues:values fieldType:appField.type];
  
  return self;
}

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
           @"fieldValues" : @"values"
           };
}

+ (NSValueTransformer *)fieldValuesValueTransformerWithDictionary:(NSDictionary *)dictionary {
  // Get the app field type
  NSString *typeString = dictionary[@"type"];
  PKTAppFieldType type = [[[NSValueTransformer pkt_appFieldTypeTransformer] transformedValue:typeString] unsignedIntegerValue];
  
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSArray *values) {
    return [self mutableFieldValuesForValues:values fieldType:type];
  }];
}


#pragma mark - Private

+ (NSMutableArray *)mutableFieldValuesForValueDictionaries:(NSArray *)valueDictionaries fieldType:(PKTAppFieldType)fieldType {
  NSMutableArray *fieldValues = [NSMutableArray arrayWithCapacity:[valueDictionaries count]];
  
  for (NSDictionary *valueDict in valueDictionaries) {
    PKTItemFieldValue *fieldValue = [PKTItemField valueWithType:fieldType valueDictionary:valueDict];
    [fieldValues addObject:fieldValue];
  }
  
  return fieldValues;
}

+ (NSMutableArray *)mutableFieldValuesForValues:(NSArray *)values fieldType:(PKTAppFieldType)fieldType {
  NSMutableArray *fieldValues = [NSMutableArray arrayWithCapacity:[values count]];
  
  for (id value in values) {
    PKTItemFieldValue *fieldValue = [PKTItemField valueWithType:fieldType unboxedValue:value];
    [fieldValues addObject:fieldValue];
  }
  
  return fieldValues;
}

+ (Class)valueClassForFieldType:(PKTAppFieldType)fieldType {
  Class klass = nil;
  
  switch (fieldType) {
    case PKTAppFieldTypeDate:
      klass = [PKTDateItemFieldValue class];
      break;
    case PKTAppFieldTypeMoney:
      klass = [PKTMoneyItemFieldValue class];
      break;
    case PKTAppFieldTypeEmbed:
      klass = [PKTEmbedItemFieldValue class];
      break;
    case PKTAppFieldTypeImage:
      klass = [PKTFileItemFieldValue class];
      break;
    case PKTAppFieldTypeApp:
      klass = [PKTAppItemFieldValue class];
      break;
    case PKTAppFieldTypeContact:
      klass = [PKTProfileItemFieldValue class];
      break;
    case PKTAppFieldTypeCalculation:
      klass = [PKTCalculationItemFieldValue class];
      break;
    case PKTAppFieldTypeCategory:
      klass = [PKTCategoryItemFieldValue class];
      break;
    default:
      klass = [PKTBasicItemFieldValue class];
      break;
  }
  
  return klass;
}

+ (PKTItemFieldValue *)valueWithType:(PKTAppFieldType)type valueDictionary:(NSDictionary *)valueDictionary {
  PKTItemFieldValue *value = nil;
  
  Class valueClass = [self valueClassForFieldType:type];
  if (valueClass) {
    value = [[valueClass alloc] initFromValueDictionary:valueDictionary];
  }
  
  return value;
}

+ (PKTItemFieldValue *)valueWithType:(PKTAppFieldType)type unboxedValue:(id)unboxedValue {
  PKTItemFieldValue *value = nil;
  
  Class valueClass = [self valueClassForFieldType:type];
  if (valueClass) {
    value = [[valueClass alloc] init];
    value.unboxedValue = unboxedValue;
  }
  
  return value;
}

- (PKTItemFieldValue *)boxedValueForValue:(id)value {
  PKTItemFieldValue *boxedValue = nil;

  Class valueClass = [[self class] valueClassForFieldType:self.type];
  if (valueClass) {
    boxedValue = [[valueClass alloc] init];
    boxedValue.unboxedValue = value;
  }
  
  return boxedValue;
}

#pragma mark - Public

- (id)valueAtIndex:(NSUInteger)index {
  PKTItemFieldValue *value = self.fieldValues[index];
  
  return value.unboxedValue;
}

- (id)firstValue {
  PKTItemFieldValue *value = [self.fieldValues firstObject];
  
  return value.unboxedValue;
}

- (void)setValues:(NSArray *)values {
  NSParameterAssert(values);
  
  NSMutableArray *fieldValues = [NSMutableArray new];
  for (id value in values) {
    PKTItemFieldValue *fieldValue = [self boxedValueForValue:value];
    [fieldValues addObject:fieldValue];
  }
  
  self.fieldValues = fieldValues;
}

- (void)setFirstValue:(id)value {
  NSParameterAssert(value);
  
  PKTItemFieldValue *fieldValue = [self boxedValueForValue:value];
  self.fieldValues[0] = fieldValue;
}

- (void)addValue:(id)value {
  NSParameterAssert(value);
  
  PKTItemFieldValue *fieldValue = [self boxedValueForValue:value];
  [self.fieldValues addObject:fieldValue];
}

- (void)removeValue:(id)value {
  NSParameterAssert(value);
  
  PKTItemFieldValue *fieldValue = [self boxedValueForValue:value];
  [self.fieldValues removeObject:fieldValue];
}

- (void)removeValueAtIndex:(NSUInteger)index {
  [self.fieldValues removeObjectAtIndex:index];
}

- (NSArray *)preparedValues {
  NSMutableArray *fieldValues = [NSMutableArray new];
  
  for (PKTItemFieldValue *value in self.fieldValues) {
    NSDictionary *valueDict = value.valueDictionary;
    if (valueDict) {
      [fieldValues addObject:valueDict];
    }
  }
  
  return [fieldValues copy];
}

@end
