//
//  PKTAppItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppItemFieldValue.h"
#import "PKTItem.h"

@implementation PKTAppItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _item = [[PKTItem alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : @(self.item.itemID)};
}

- (void)setUnboxedValue:(id)unboxedValue {
  self.item = unboxedValue;
}

- (id)unboxedValue {
  return self.item;
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return [value isKindOfClass:[PKTItem class]];
}

@end
