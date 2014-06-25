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

@implementation PKTEmbedItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTEmbed alloc] initWithDictionary:valueDictionary[kEmbedKey]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTEmbed *embed = self.unboxedValue;
  
  return @{kEmbedKey : @(embed.embedID)};
}

+ (Class)unboxedValueClass {
  return [PKTEmbed class];
}

@end
