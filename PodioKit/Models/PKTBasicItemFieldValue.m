//
//  PKTBasicItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBasicItemFieldValue.h"

@interface PKTBasicItemFieldValue ()

@end

@implementation PKTBasicItemFieldValue

#pragma mark - PKTItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _value = valueDictionary[@"value"];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : self.value };
}

- (void)setUnboxedValue:(id)unboxedValue {
  self.value = unboxedValue;
}

- (id)unboxedValue {
  return self.value;
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return YES;
}

@end
