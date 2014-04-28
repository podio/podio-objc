//
//  PKTItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemFieldValue.h"
#import "PKTBasicItemFieldValue.h"
#import "PKTDateItemFieldValue.h"
#import "PKTMoneyItemFieldValue.h"
#import "PKTEmbedItemFieldValue.h"
#import "PKTFileItemFieldValue.h"
#import "PKTAppItemFieldValue.h"
#import "PKTContactItemFieldValue.h"
#import "PKTCalculationItemFieldValue.h"
#import "PKTCategoryItemFieldValue.h"

@interface PKTItemFieldValue ()

@end

@implementation PKTItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  return self;
}

+ (instancetype)valueFromDictionary:(NSDictionary *)valueDictionary {
  return [[self alloc] initFromValueDictionary:valueDictionary];
}

+ (instancetype)valueWithType:(PKTAppFieldType)type valueDictionary:(NSDictionary *)valueDictionary {
  PKTItemFieldValue *value = nil;
  
  switch (type) {
    case PKTAppFieldTypeDate:
      value = [[PKTDateItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeMoney:
      value = [[PKTMoneyItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeEmbed:
      value = [[PKTEmbedItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeImage:
      value = [[PKTFileItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeApp:
      value = [[PKTAppItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeContact:
      value = [[PKTContactItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeCalculation:
      value = [[PKTCalculationItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeCategory:
      value = [[PKTCategoryItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
    default:
      value = [[PKTBasicItemFieldValue alloc] initFromValueDictionary:valueDictionary];
      break;
  }
  
  return value;
}

- (NSDictionary *)valueDictionary {
  // Return nil by default, meaning it cannot be serialized back. e.g. calculation field
  return nil;
}

@end
