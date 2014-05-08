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
    return [NSDate pkt_dateFromUTCDateTimeString:dateString];
  } reverseBlock:^id(NSDate *date) {
    return [date pkt_UTCDateTimeString];
  }];
}

@end
