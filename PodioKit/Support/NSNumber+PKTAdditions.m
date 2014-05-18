//
//  NSNumber(PKTAdditions) 
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//


#import "NSNumber+PKTAdditions.h"
#import "NSNumberFormatter+PKTAdditions.h"

static NSNumberFormatter *sNumberFormatter = nil;

@implementation NSNumber (PKTAdditions)

+ (NSNumber *)pkt_numberFromUSNumberString:(NSString *)numberString {
  return [[self pkt_USNumberFormatter] numberFromString:numberString];
}

- (NSString *)pkt_USNumberString {
  return [[[self class] pkt_USNumberFormatter] stringFromNumber:self];
}

+ (NSNumberFormatter *)pkt_USNumberFormatter {
  if (!sNumberFormatter) {
    sNumberFormatter = [NSNumberFormatter pkt_USNumberFormatter];
  }

  return sNumberFormatter;
}

@end