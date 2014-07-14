//
//  NSString+PKTAdditions.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSString+PKTAdditions.h"

@implementation NSString (PKTAdditions)

- (BOOL)pkt_containsString:(NSString *)string {
  return [self rangeOfString:string].location != NSNotFound;
}

@end
