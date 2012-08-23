//
//  PKItemFieldValueCalculationData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueCalculationData.h"


static NSString * const PKItemFieldValueCalculationDataValueKey = @"Value";
static NSString * const PKItemFieldValueCalculationDataUnitKey = @"Unit";

@implementation PKItemFieldValueCalculationData

@synthesize value = value_;
@synthesize unit = unit_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    value_ = [[aDecoder decodeObjectForKey:PKItemFieldValueCalculationDataValueKey] copy];
    unit_ = [[aDecoder decodeObjectForKey:PKItemFieldValueCalculationDataUnitKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:value_ forKey:PKItemFieldValueCalculationDataValueKey];
  [aCoder encodeObject:unit_ forKey:PKItemFieldValueCalculationDataUnitKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueCalculationData *data = [self data];
  
  data.value = [dict pk_numberFromStringForKey:@"value"];

  return data;
}

@end
