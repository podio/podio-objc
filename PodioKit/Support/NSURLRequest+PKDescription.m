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
  NSMutableString *mutString = [[NSMutableString alloc] init];
  
  [mutString appendString:@"--------------------------------------------------\n"];
  
  [mutString appendFormat:@"%@ %@\n", self.HTTPMethod, [self.URL absoluteString]];
  [mutString appendString:@"Headers:\n"];
  [self.allHTTPHeaderFields enumerateKeysAndObjectsUsingBlock:^(id name, id value, BOOL *stop) {
    [mutString appendFormat:@"  %@=%@\n", name, value];
  }];
  
  if ([self.HTTPBody length] > 0) {
    [mutString appendString:@"Body:\n"];
    [mutString appendFormat:@"  %@\n", [[NSString alloc] initWithData:self.HTTPBody encoding:NSUTF8StringEncoding]];
  }
  
  [mutString appendString:@"--------------------------------------------------"];
  
  return [mutString copy];
}

@end
