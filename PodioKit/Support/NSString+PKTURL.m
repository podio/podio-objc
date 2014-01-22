//
//  NSString+PKTURL.m
//  PodioKit
//
//  Created by Romain Briche on 22/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSString+PKTURL.h"

@implementation NSString (PKTURL)

- (instancetype)pkt_escapedURLString {
  NSString *escapedString = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                   (__bridge CFStringRef)self,
                                                                                                   NULL,
                                                                                                   (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8);
  return escapedString;
}

- (instancetype)pkt_unescapedURLString {
  NSString *unescapedString = (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                     (__bridge CFStringRef)self,
                                                                                                                     CFSTR(""),
                                                                                                                     kCFStringEncodingUTF8);
  return unescapedString;
}

- (NSDictionary *)pkt_URLQueryParameters {
  NSMutableDictionary *params = [NSMutableDictionary new];

  NSArray *chunks = [self componentsSeparatedByString:@"&"];
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
