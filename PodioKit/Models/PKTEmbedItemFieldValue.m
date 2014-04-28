//
//  PKTEmbedItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTEmbedItemFieldValue.h"
#import "PKTEmbed.h"
#import "PKTFile.h"

@implementation PKTEmbedItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _embed = [[PKTEmbed alloc] initWithDictionary:valueDictionary[@"embed"]];
  _file = [[PKTFile alloc] initWithDictionary:valueDictionary[@"file"]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  NSMutableDictionary *dict = [NSMutableDictionary new];
  dict[@"embed"] = @(self.embed.embedID);
  
  if (self.file) {
      dict[@"file"] = @(self.file.fileID);
  }
  
  return [dict copy];
}

@end
