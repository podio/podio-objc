//
//  PKTProgressItemFieldValue.m
//  PodioKit
//
//  Created by Romain Briche on 08/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTProgressItemFieldValue.h"
#import "NSNumber+PKTAdditions.h"

@implementation PKTProgressItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initFromValueDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = valueDictionary[@"value"];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  NSNumber *number = self.unboxedValue;
  
  return @{@"value" : number};
}

+ (Class)unboxedValueClass {
  return [NSNumber class];
}

@end
