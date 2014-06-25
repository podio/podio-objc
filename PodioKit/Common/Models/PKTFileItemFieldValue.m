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
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTFile alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTFile *file = self.unboxedValue;
  
  return @{@"value" : @(file.fileID)};
}

+ (Class)unboxedValueClass {
  return [PKTFile class];
}

@end
