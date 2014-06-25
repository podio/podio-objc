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
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTItem alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTItem *item = self.unboxedValue;
  
  return @{@"value" : @(item.itemID)};
}

+ (Class)unboxedValueClass {
  return [PKTItem class];
}

@end
