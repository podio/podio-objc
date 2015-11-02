//
//  PKTTagItemFieldValue.m
//  PodioKit
//
//  Created by Lauge Jepsen on 02/11/2015.
//  Copyright © 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTagItemFieldValue.h"
#import "NSArray+PKTAdditions.h"

@implementation PKTTagItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initFromValueDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = valueDictionary[@"value"];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  NSString *tag = self.unboxedValue;
  
  return @{@"value": tag};
}

+ (Class)unboxedValueClass {
  return [NSString class];
}


@end
