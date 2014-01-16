//
//  NSDictionary+PKAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSDictionary+PKAdditions.h"


@implementation NSDictionary (PKAdditions)

- (id)pk_objectForKey:(id)key {
  // Avoid NSNull
  id obj = [self objectForKey:key];
  return ![obj isKindOfClass:[NSNull class]] ? obj : nil;
}

- (id)pk_objectForPathComponents:(NSArray *)pathComponents {
  id value = self;
  if (pathComponents != nil) {
    for (NSString *component in pathComponents) {
      
      value = [value pk_objectForKey:component];
      if (value == nil || ![value isKindOfClass:[NSDictionary class]]) {
        break;
      }
    }
  }
  
  return value;
}

- (NSDictionary *)pk_dictionaryByMergingDictionary:(NSDictionary *)dictionary {
  NSMutableDictionary *mutDictionary = [[NSMutableDictionary alloc] init];
  [mutDictionary addEntriesFromDictionary:self];
  [mutDictionary addEntriesFromDictionary:dictionary];

  return [mutDictionary copy];
}

@end
