//
//  NSString+URL.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)

- (NSString *)pk_escapedURLString {
  NSString *escapedString = (__bridge_transfer NSString *) CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef) @"!*'();:@&=+$,/?%#[]",
                                                                                 kCFStringEncodingUTF8);
  return escapedString;
}

@end
