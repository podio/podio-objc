//
//  NSString+Hash.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/3/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "NSString+Hash.h"

@implementation NSString (Hash)

- (NSString *)pk_MD5String {
  const char *src = [self UTF8String];
  unsigned char result[CC_MD5_DIGEST_LENGTH];
  CC_MD5(src, strlen(src), result);
  NSString *ret = 
  [[NSString alloc] initWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
    result[0], result[1], result[2], result[3],
    result[4], result[5], result[6], result[7],
    result[8], result[9], result[10], result[11],
    result[12], result[13], result[14], result[15]
    ];
  return [ret lowercaseString];
}

- (NSString *)pk_SHA1String {
  NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
  uint8_t digest[CC_SHA1_DIGEST_LENGTH];
  
  CC_SHA1(data.bytes, data.length, digest);
  
  NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
  
  for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    [output appendFormat:@"%02x", digest[i]];
  
  return output;
}

@end
