//
//  PKTItemField.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemField.h"
#import "PKTItemFieldValue.h"
#import "PKTStringItemFieldValue.h"
#import "PKTDateItemFieldValue.h"
#import "PKTMoneyItemFieldValue.h"
#import "PKTEmbedItemFieldValue.h"
#import "PKTFileItemFieldValue.h"
#import "PKTAppItemFieldValue.h"
#import "PKTProfileItemFieldValue.h"
#import "PKTCalculationItemFieldValue.h"
#import "PKTCategoryItemFieldValue.h"
#import "PKTDurationItemFieldValue.h"
#import "PKTLocationItemFieldValue.h"
#import "PKTFile.h"
#import "PKTCategoryOption.h"
#import "PKTNumberItemFieldValue.h"
#import "PKTAppFieldConfig.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTDateRange.h"

@interface PKTItemField ()

@property (nonatomic, strong) NSMutableArray *fieldValues;

@end

@implementation PKTItemField

- (instancetype)initWithFieldID:(NSUInteger)fieldID externalID:(NSString *)externalID type:(PKTAppFieldType)type config:(PKTAppFieldConfig *)config values:(NSArray *)values {
  self = [super initWithFieldID:fieldID externalID:externalID type:type config:config];
  if (!self) return nil;

  _fieldValues = [values mutableCopy];

  return self;
}

- (instancetype)initWithAppField:(PKTAppField *)appField basicValues:(NSArray *)basicValues {
  NSArray *values = [[self class] mutableFieldValuesForBasicValues:basicValues field:appField];
  PKTItemField *field = [self initWithFieldID:appField.fieldID externalID:appField.externalID type:appField.type config:appField.config values:values];

  return field;
}

- (instancetype)initWithFieldID:(NSUInteger)fieldID externalID:(NSString *)externalID type:(PKTAppFieldType)type config:(PKTAppFieldConfig *)config {
  return [self initWithFieldID:fieldID externalID:externalID type:type config:config values:nil];
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

/* Validates that the provided unboxed value is supported for the given fieldType.
 *
 * @param value The unboxed value.
 * @param fieldType The field type for which to validate that the unboxed value can be used.
 *
 * @exception InvalidFieldValueException Thrown if the provided value is cannot be boxed for the given field type.
 */
+ (void)validateUnboxedValue:(id)value forFieldType:(PKTAppFieldType)fieldType {
  NSError *error = nil;
  if (![PKTItemField isSupportedValue:value forFieldType:fieldType error:&error]) {
    NSString *reason = [NSString stringWithFormat:@"Invalid field value: %@", [error localizedDescription]];
    NSException *exception = [NSException exceptionWithName:@"InvalidFieldValueException" reason:reason userInfo:nil];

    @throw exception;
  }
}

+ (NSMutableArray *)mutableFieldValuesForValueDictionaries:(NSArray *)valueDictionaries fieldType:(PKTAppFieldType)fieldType {
  NSMutableArray *fieldValues = [NSMutableArray arrayWithCapacity:[valueDictionaries count]];
  
  for (NSDictionary *valueDict in valueDictionaries) {
    PKTItemFieldValue *fieldValue = [PKTItemField valueWithType:fieldType valueDictionary:valueDict];
    [fieldValues addObject:fieldValue];
  }
  
  return fieldValues;
}

+ (NSMutableArray *)mutableFieldValuesForBasicValues:(NSArray *)basicValues field:(PKTAppField *)field {
  NSMutableArray *fieldValues = [NSMutableArray arrayWithCapacity:[basicValues count]];
  
  for (id value in basicValues) {
    [self validateUnboxedValue:value forFieldType:field.type];
    
    PKTItemFieldValue *fieldValue = [PKTItemField boxedValueForValue:value forFieldType:field.type];
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
    case PKTAppFieldTypeText:
      valueClass = [PKTStringItemFieldValue class];
      break;
    case PKTAppFieldTypeLocation:
      valueClass = [PKTLocationItemFieldValue class];
      break;
    default:
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

+ (PKTItemFieldValue *)boxedValueForValue:(id)value forFieldType:(PKTAppFieldType)type {
  PKTItemFieldValue *boxedValue = nil;
  
  Class valueClass = [self valueClassForFieldType:type];
  if (valueClass) {
    boxedValue = [[valueClass alloc] init];
    boxedValue.unboxedValue = value;
  }
  
  return boxedValue;
}

- (PKTItemFieldValue *)boxedValueForValue:(id)value {
  return [[self class] boxedValueForValue:value forFieldType:self.type];
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
