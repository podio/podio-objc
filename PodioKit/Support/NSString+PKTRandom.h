//
//  NSString+PKRandom.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/5/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PKTRandom)

+ (instancetype)pkt_randomHexStringOfLength:(NSUInteger)length;

@end
