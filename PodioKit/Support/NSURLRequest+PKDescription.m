//
//  NSURLRequest+PKDescription.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/3/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSURLRequest+PKDescription.h"

@implementation NSURLRequest (PKDescription)

- (NSString *)pk_description {
  NSMutableString *mutString = [NSMutableString stringWithFormat:@"%@ %@", self.HTTPMethod, [self.URL absoluteString]];

  [mutString appendString:@"\n  Headers:"];
  [self.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id name, id value, BOOL *stop) {
    [mutString appendFormat:@"\n    %@=%@", name, value];
  }];
  
  [mutString appendString:@"\n  Body:"];
  [mutString appendFormat:@"\n    %@", [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]];
  
  return [mutString copy];
}

@end
