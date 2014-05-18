//
//  PKTDateItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateItemFieldValue.h"
#import "PKTDateRange.h"
#import "NSDate+PKTAdditions.h"

static NSString * const kStartDateKey = @"start";
static NSString * const kEndDateKey = @"end";

@implementation PKTDateItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super initWithDictionary:valueDictionary];
  if (!self) return nil;
  
  self.unboxedValue = [[PKTDateRange alloc] initWithDictionary:valueDictionary];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  PKTDateRange *dateRange = self.unboxedValue;
  
  return @{kStartDateKey : [dateRange.startDate pkt_UTCDateTimeString],
           kEndDateKey : [dateRange.endDate pkt_UTCDateTimeString]};
}

+ (Class)unboxedValueClass {
  return [PKTDateRange class];
}

@end
