//
//  NSNumber+PKFormat.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/22/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "NSNumber+PKFormat.h"

static NSNumberFormatter *sUSNumberFormatter;

@implementation NSNumber (PKFormat)

- (NSString *)pk_numberStringWithUSLocale {
  return [[[self class] pk_USNumberFormatter] stringFromNumber:self];
}

+ (NSNumber *)pk_numberFromStringWithUSLocale:(NSString *)string {
  return [[[self class] pk_USNumberFormatter] numberFromString:string];
}

#pragma mark - Private

+ (NSNumberFormatter *)pk_USNumberFormatter {
  if (!sUSNumberFormatter) {
    sUSNumberFormatter = [[NSNumberFormatter alloc] init];
    [sUSNumberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    sUSNumberFormatter.usesGroupingSeparator = NO;
    
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    [sUSNumberFormatter setLocale:locale];
  }
  
  return sUSNumberFormatter;
}

@end
