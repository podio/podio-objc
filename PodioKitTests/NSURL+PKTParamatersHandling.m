//
//  NSURL+PKTParamatersHandling.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSURL+PKTParamatersHandling.h"
#import "NSString+PKTURL.h"

@implementation NSURL (PKTParamatersHandling)

- (NSString *)pkt_valueForQueryParameter:(NSString *)parameter {
  return [self pkt_queryParameters][parameter];
}

- (NSDictionary *)pkt_queryParameters {
  NSMutableDictionary *params = [NSMutableDictionary new];

  NSArray *chunks = [[self query] componentsSeparatedByString:@"&"];
  for (id obj in chunks) {
    NSArray *parts = [obj componentsSeparatedByString:@"="];

    if ([parts count] == 2) {
      NSString *name = parts[0];
      NSString *value = parts[1];
      params[name] = [value pkt_unescapedURLString];
    }
  }

  return [params copy];
}

@end
