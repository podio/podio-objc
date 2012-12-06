//
//  NSString+PKRandom.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/5/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "NSString+PKRandom.h"

#define NUMBER_OF_CHARS 8

@implementation NSString (PKRandom)

+ (NSString *)pk_randomHexStringOfLength:(NSUInteger)length {
  char data[length];
  
  for (NSUInteger i = 0; i < length; ++i) {
    u_int32_t rand = arc4random_uniform(36);
    data[i] = rand < 10 ? '0' + rand : 'a' + (rand - 10);
  }
  
  return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
}

@end
