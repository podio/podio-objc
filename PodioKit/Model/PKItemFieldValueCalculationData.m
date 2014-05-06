//
//  PKItemFieldValueCalculationData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueCalculationData.h"


static NSString * const PKItemFieldValueCalculationDataValueDictionaryKey = @"ValueDictionary";

@interface PKItemFieldValueCalculationData ()

@property (nonatomic, copy) NSDictionary *valueDictionary;

@end

@implementation PKItemFieldValueCalculationData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _valueDictionary = [[aDecoder decodeObjectForKey:PKItemFieldValueCalculationDataValueDictionaryKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:_valueDictionary forKey:PKItemFieldValueCalculationDataValueDictionaryKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueCalculationData *data = [self data];
  
  data.valueDictionary = dict;

  return data;
}

@end
