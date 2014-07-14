//
//  NSDictionary+PKTQueryParameters.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSDictionary+PKTQueryParameters.h"
#import "NSString+PKTURLEncode.h"
#import "NSArray+PKTAdditions.h"

@implementation NSDictionary (PKTQueryParameters)

- (NSString *)pkt_queryString {
  return [self pkt_queryStringByEscapingValues:NO];
}

- (NSString *)pkt_escapedQueryString {
  return [self pkt_queryStringByEscapingValues:YES];
}

- (NSDictionary *)pkt_queryParametersPairs {
  return [self pkt_flattenedKeysAndValuesWithKeyMappingBlock:nil];
}

- (NSDictionary *)pkt_escapedQueryParametersPairs {
  NSMutableDictionary *escapedPairs = [NSMutableDictionary new];
  
  NSDictionary *pairs = [self pkt_queryParametersPairs];
  [pairs enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
    NSString *stringValue = [value isKindOfClass:[NSString class]] ? value : [NSString stringWithFormat:@"%@", value];
    escapedPairs[key] = [stringValue pkt_encodeString];
  }];
  
  return [escapedPairs copy];
}

#pragma mark - Private

- (NSDictionary *)pkt_flattenedKeysAndValuesWithKeyMappingBlock:(NSString * (^)(id key))keyMappingBlock {
  NSMutableDictionary *pairs = [NSMutableDictionary new];
  
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
    NSString *currentKey = keyMappingBlock ? keyMappingBlock(key) : key;
    
    if ([value isKindOfClass:[NSDictionary class]]) {
      NSDictionary *subKeysAndValues = [value pkt_flattenedKeysAndValuesWithKeyMappingBlock:^NSString *(id subKey) {
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

- (NSString *)pkt_queryStringByEscapingValues:(BOOL)escapeValues {
  NSMutableArray *pairs = [NSMutableArray new];
  
  NSDictionary *escapedPairs = escapeValues ? [self pkt_escapedQueryParametersPairs] : [self pkt_queryParametersPairs];
  [escapedPairs enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
    NSString *pair = [NSString stringWithFormat:@"%@=%@", key, value];
    [pairs addObject:pair];
  }];
  
  return [pairs componentsJoinedByString:@"&"];
}

@end
