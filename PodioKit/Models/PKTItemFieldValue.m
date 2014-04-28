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
      value = [PKTDateItemFieldValue valueFromDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeMoney:
      value = [PKTMoneyItemFieldValue valueFromDictionary:valueDictionary];
      break;
    case PKTAppFieldTypeEmbed:
      value = [PKTEmbedItemFieldValue valueFromDictionary:valueDictionary];
      break;
    default:
      value = [PKTBasicItemFieldValue valueFromDictionary:valueDictionary];
      break;
  }
  
  return value;
}

- (NSDictionary *)valueDictionary {
  return nil;
}

@end
