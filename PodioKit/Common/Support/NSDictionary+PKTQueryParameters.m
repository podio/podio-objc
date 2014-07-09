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

- (NSString *)pkt_queryStringByEscapingValues:(BOOL)escapeValues {
  NSMutableArray *pairs = [NSMutableArray new];
  
  [self enumerateKeysAndObjectsUsingBlock:^(NSString *name, id value, BOOL *stop) {
    NSString *stringValue = nil;
    if ([value isKindOfClass:[NSDictionary class]]) {
      stringValue = [value pkt_queryStringByEscapingValues:NO];
    } else {
      stringValue = value;
    }
    
    if (escapeValues) {
      stringValue = [stringValue pkt_encodeString];
    }
    
    NSString *pair = [NSString stringWithFormat:@"%@=%@", name, stringValue];
    [pairs addObject:pair];
  }];
  
  return [pairs componentsJoinedByString:@"&"];
}

@end
