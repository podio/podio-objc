//
//  PKTFileItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFileItemFieldValue.h"
#import "PKTFile.h"

@implementation PKTFileItemFieldValue

#pragma mark - PKTItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _file = [[PKTFile alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : @(self.file.fileID)};
}

- (void)setUnboxedValue:(id)unboxedValue {
  NSAssert([unboxedValue isKindOfClass:[PKTFile class]], @"The unboxed value for file value needs to be a PKTFile.");
  self.file = unboxedValue;
}

- (id)unboxedValue {
  return self.file;
}

@end
