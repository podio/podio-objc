//
//  NSNumberFormatter(PKTAdditions) 
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import "NSNumberFormatter+PKTAdditions.h"

@implementation NSNumberFormatter (PKTAdditions)

+ (NSNumberFormatter *)pkt_USNumberFormatter {
  NSNumberFormatter *formatter = [NSNumberFormatter new];
  formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
  formatter.numberStyle = NSNumberFormatterDecimalStyle;
  formatter.usesGroupingSeparator = NO;

  return formatter;
}

@end