//
//  NSDictionary+PKTQueryParameters.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSDictionary+PKTQueryParameters.h"
#import "NSString+PKTURLEncode.h"

@implementation NSDictionary (PKTQueryParameters)

- (NSString *)pkt_queryString {
  return [self pkt_queryStringByEscapingValues:NO];
}

- (NSString *)pkt_escapedQueryString {
  return [self pkt_queryStringByEscapingValues:YES];
}

#pragma mark - Private

- (NSDictionary *)pkt_flattenedKeysAndValuesWithKeyMap:(NSString * (^)(id key))keyMap {
  NSMutableDictionary *pairs = [NSMutableDictionary new];
  
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
    NSString *currentKey = keyMap ? keyMap(key) : key;
    
    if ([value isKindOfClass:[NSDictionary class]]) {
      NSDictionary *subKeysAndValues = [value pkt_flattenedKeysAndValuesWithKeyMap:^NSString *(id subKey) {
        // Sub-keys should appear in brackets
        return [NSString stringWithFormat:@"[%@]", subKey];
      }];
      
      [subKeysAndValues enumerateKeysAndObjectsUsingBlock:^(id subKey, id subValue, BOOL *stop) {
        NSString *fullKey = [currentKey stringByAppendingString:subKey];
        pairs[fullKey] = subValue;
      }];
    } else {
      pairs[currentKey] = value;
    }
  }];
  
  return [pairs copy];
}

- (NSDictionary *)pkt_flattenedKeysAndValues {
  return [self pkt_flattenedKeysAndValuesWithKeyMap:nil];
}

- (NSString *)pkt_queryStringByEscapingValues:(BOOL)escapeValues {
  NSMutableArray *pairs = [NSMutableArray new];
  
  NSDictionary *keysAndValues = [self pkt_flattenedKeysAndValues];
  [keysAndValues enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
    if (escapeValues) {
      value = [value pkt_encodeString];
    }
    
    NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
    [pairs addObject:pair];
  }];
  
  return [pairs componentsJoinedByString:@"&"];
}

@end
