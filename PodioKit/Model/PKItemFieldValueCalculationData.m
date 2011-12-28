//
//  POTransformableCalculationData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/29/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueCalculationData.h"


static NSString * const POTransformableCalculationDataValueKey = @"Value";
static NSString * const POTransformableCalculationDataUnitKey = @"Unit";

@implementation PKItemFieldValueCalculationData

@synthesize value = value_;
@synthesize unit = unit_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    value_ = [[aDecoder decodeObjectForKey:POTransformableCalculationDataValueKey] copy];
    unit_ = [[aDecoder decodeObjectForKey:POTransformableCalculationDataUnitKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:value_ forKey:POTransformableCalculationDataValueKey];
  [aCoder encodeObject:unit_ forKey:POTransformableCalculationDataUnitKey];
}

- (void)dealloc {
  [value_ release];
  [unit_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueCalculationData *data = [self data];
  
  data.value = [dict pk_numberFromStringForKey:@"value"];
  
//  TODO: Include unit
//  data.unit = [[[dict pk_objectForKey:@"config"] pk_objectForKey:@"settings"] pk_objectForKey:@"unit"];
  
  return data;
}

@end
