//
//  PKTNumberItemFieldValue 
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import "PKTNumberItemFieldValue.h"
#import "NSNumber+PKTAdditions.h"

@implementation PKTNumberItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initFromValueDictionary:valueDictionary];
  if (!self) return nil;

  self.unboxedValue = [NSNumber pkt_numberFromUSNumberString:valueDictionary[@"value"]];

  return self;
}

- (NSDictionary *)valueDictionary {
  NSNumber *number = self.unboxedValue;

  return @{@"value" : [number pkt_USNumberString]};
}

+ (Class)unboxedValueClass {
  return [NSNumber class];
}

@end