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

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _file = [[PKTFile alloc] initWithDictionary:valueDictionary[@"value"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{@"value" : @(self.file.fileID)};
}

@end
