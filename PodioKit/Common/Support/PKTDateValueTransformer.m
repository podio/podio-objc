//
//  PKTDateValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateValueTransformer.h"
#import "NSDate+PKTAdditions.h"

@implementation PKTDateValueTransformer

- (instancetype)init {
  return [super initWithBlock:^id(NSString *dateString) {
    NSDate *date = [NSDate pkt_dateFromUTCDateTimeString:dateString];
    if (!date) {
      // Failed to parse time component, try date only
      date = [NSDate pkt_dateFromUTCDateString:dateString];
    }
    
    return date;
  } reverseBlock:^id(NSDate *date) {
    return [date pkt_UTCDateTimeString];
  }];
}

@end
