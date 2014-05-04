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

static NSString * const kEmbedKey = @"embed";
static NSString * const kFileKey = @"file";

@implementation PKTEmbedItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  _embed = [[PKTEmbed alloc] initWithDictionary:valueDictionary[kEmbedKey]];
  _file = [[PKTFile alloc] initWithDictionary:valueDictionary[kFileKey]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{kEmbedKey : @(self.embed.embedID)};
}

- (void)setUnboxedValue:(id)unboxedValue {
  self.embed = unboxedValue;
}

- (id)unboxedValue {
  return self.embed;
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return [value isKindOfClass:[PKTEmbed class]];
}

@end
