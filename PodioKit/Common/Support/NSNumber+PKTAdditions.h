//
//  NSNumber(PKTAdditions) 
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSNumber (PKTAdditions)

+ (NSNumber *)pkt_numberFromUSNumberString:(NSString *)numberString;
- (NSString *)pkt_USNumberString;

@end