//
//  NSDictionary+URL.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "NSDictionary+URL.h"
#import "NSString+URL.h"

@implementation NSDictionary (URL)

- (NSString *)pk_escapedURLStringFromComponents {
  NSMutableArray *components = [[NSMutableArray alloc] initWithCapacity:[self count]]; 
  [self enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
    NSString *param = [NSString stringWithFormat:@"%@=%@", [key pk_escapedURLString], [value pk_escapedURLString]];
    [components addObject:param];
  }];
  
  return [components componentsJoinedByString:@"&"];
}

@end
