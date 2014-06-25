//
//  NSString(PKTBase64) 
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/06/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import "NSString+PKTBase64.h"

@implementation NSString (PKTBase64)

- (NSString *)pkt_base64String {
  NSData *data = [NSData dataWithBytes:[self UTF8String] length:[self lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
  const uint8_t* input = (const uint8_t*)[data bytes];
  NSInteger length = [data length];

  static char table[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

  NSMutableData* outputData = [NSMutableData dataWithLength:((length + 2) / 3) * 4];
  uint8_t* output = (uint8_t*)outputData.mutableBytes;

  NSInteger i;
  for (i=0; i < length; i += 3) {
    NSInteger value = 0;
    NSInteger j;
    for (j = i; j < (i + 3); j++) {
      value <<= 8;

      if (j < length) {
        value |= (0xFF & input[j]);
      }
    }

    NSInteger theIndex = (i / 3) * 4;
    output[theIndex + 0] =                    table[(value >> 18) & 0x3F];
    output[theIndex + 1] =                    table[(value >> 12) & 0x3F];
    output[theIndex + 2] = (i + 1) < length ? table[(value >> 6)  & 0x3F] : '=';
    output[theIndex + 3] = (i + 2) < length ? table[(value >> 0)  & 0x3F] : '=';
  }

  return [[NSString alloc] initWithData:outputData encoding:NSASCIIStringEncoding];
}

@end