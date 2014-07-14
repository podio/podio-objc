//
//  NSString+PKTURLEncode.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSString+PKTURLEncode.h"

@implementation NSString (PKTURLEncode)

- (NSString *)pkt_encodeString {
  NSString *escapedString = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                   (__bridge CFStringRef)self,
                                                                                                   NULL,
                                                                                                   (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                                                   kCFStringEncodingUTF8);
  return escapedString;
}

- (NSString *)pkt_decodeString {
  NSString *escapedString = (__bridge_transfer NSString *) CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                                   (__bridge CFStringRef)self,
                                                                                                                   CFSTR(""),
                                                                                                                   kCFStringEncodingUTF8);
  return escapedString;
}

@end
