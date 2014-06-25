//
//  PKTStringItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTStringItemFieldValue.h"

@interface PKTStringItemFieldValue ()

@end

@implementation PKTStringItemFieldValue

#pragma mark - PKTItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = valueDictionary[@"value"];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : self.unboxedValue };
}

+ (Class)unboxedValueClass {
  return [NSString class];
}

@end
