//
//  PKTDateValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateValueTransformer.h"
#import "NSDate+PKTAdditions.h"
#import "PKTMacros.h"

@implementation PKTDateValueTransformer

- (instancetype)init {
  PKT_WEAK_SELF weakSelf = self;
  
  return [super initWithBlock:^id(NSString *dateString) {
    NSDate *date = [NSDate pkt_dateFromUTCDateTimeString:dateString];
    if (!date) {
      // Failed to parse time component, try date only
      date = [NSDate pkt_dateFromUTCDateString:dateString];
    }
    
    return date;
  } reverseBlock:^id(NSDate *date) {
    PKT_STRONG(weakSelf) strongSelf = weakSelf;
    
    NSString *dateString = nil;
    
    if (strongSelf.ignoresTimeComponent) {
      dateString = [date pkt_UTCDateString];
    } else {
      dateString = [date pkt_UTCDateTimeString];
    }
    
    return dateString;
  }];
}

@end
