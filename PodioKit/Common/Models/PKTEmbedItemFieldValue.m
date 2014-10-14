//
//  PKTEmbedItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTEmbedItemFieldValue.h"
#import "PKTEmbed.h"

static NSString * const kEmbedKey = @"embed";
static NSString * const kURLKey = @"url";

@implementation PKTEmbedItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTEmbed alloc] initWithDictionary:valueDictionary[kEmbedKey]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  NSDictionary *dict = nil;
  
  if ([self.unboxedValue isKindOfClass:[PKTEmbed class]]) {
    PKTEmbed *embed = self.unboxedValue;
    dict = @{kEmbedKey : @(embed.embedID)};
  } else if ([self.unboxedValue isKindOfClass:[NSString class]]) {
    dict = @{kURLKey : self.unboxedValue};
  }
  
  return dict;
}

+ (NSArray *)unboxedValueClasses {
  return @[[PKTEmbed class], [NSString class]];
}

@end
