//
//  PKTDateValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateValueTransformer.h"
#import "NSDateFormatter+PKTAdditions.h"

static NSDateFormatter * sDateFormatter = nil;

@implementation PKTDateValueTransformer

+ (void)initialize {
  if (self == [PKTDateValueTransformer class]) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sDateFormatter = [NSDateFormatter pkt_UTCDateFormatter];
    });
  }
}

- (instancetype)init {
  return [super initWithBlock:^id(NSString *dateString) {
    return [sDateFormatter dateFromString:dateString];
  } reverseBlock:^id(NSDate *date) {
    return [sDateFormatter stringFromDate:date];
  }];
}

@end
