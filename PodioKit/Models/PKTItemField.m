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
#import "PKTDurationItemFieldValue.h"
#import "PKTFile.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTNumberItemFieldValue.h"

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
    return [self mutableFieldValuesForValueDictionaries:values fieldType:type];
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
  Class valueClass = nil;
  
  switch (fieldType) {
    case PKTAppFieldTypeDate:
      valueClass = [PKTDateItemFieldValue class];
      break;
    case PKTAppFieldTypeMoney:
      valueClass = [PKTMoneyItemFieldValue class];
      break;
    case PKTAppFieldTypeEmbed:
      valueClass = [PKTEmbedItemFieldValue class];
      break;
    case PKTAppFieldTypeImage:
      valueClass = [PKTFileItemFieldValue class];
      break;
    case PKTAppFieldTypeApp:
      valueClass = [PKTAppItemFieldValue class];
      break;
    case PKTAppFieldTypeContact:
      valueClass = [PKTProfileItemFieldValue class];
      break;
    case PKTAppFieldTypeCalculation:
      valueClass = [PKTCalculationItemFieldValue class];
      break;
    case PKTAppFieldTypeCategory:
      valueClass = [PKTCategoryItemFieldValue class];
      break;
    case PKTAppFieldTypeDuration:
      valueClass = [PKTDurationItemFieldValue class];
      break;
    case PKTAppFieldTypeNumber:
    case PKTAppFieldTypeProgress:
      valueClass = [PKTNumberItemFieldValue class];
      break;
    default:
      valueClass = [PKTBasicItemFieldValue class];
      break;
  }
  
  return valueClass;
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

+ (BOOL)isSupportedValue:value forFieldType:(PKTAppFieldType)fieldType error:(NSError **)error {
  BOOL isSupported = NO;
  
  Class valueClass = [[self class] valueClassForFieldType:fieldType];
  if ([valueClass isSubclassOfClass:[PKTItemFieldValue class]] && valueClass) {
    isSupported = [valueClass supportsBoxingOfValue:value error:error];
  }
  
  return isSupported;
}

- (id)value {
  PKTItemFieldValue *value = [self.fieldValues firstObject];
  
  return value.unboxedValue;
}

- (void)setValue:(id)value {
  NSParameterAssert(value);
  
  PKTItemFieldValue *fieldValue = [self boxedValueForValue:value];
  
  [self.fieldValues removeAllObjects];
  [self.fieldValues addObject:fieldValue];
}

- (NSArray *)values {
  NSMutableArray *values = [NSMutableArray new];
  for (PKTItemFieldValue *fieldValue in self.fieldValues) {
    [values addObject:fieldValue.unboxedValue];
  }
  
  return [values copy];
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
