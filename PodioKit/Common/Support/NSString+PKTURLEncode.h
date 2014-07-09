//
//  NSString+PKTURLEncode.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PKTURLEncode)

- (NSString *)pkt_encodeString;
- (NSString *)pkt_decodeString;

@end
