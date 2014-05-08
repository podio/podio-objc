//
//  PKTDateItemFieldValue.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTDateItemFieldValue.h"
#import "NSDate+PKTAdditions.h"

static NSString * const kStartDateKey = @"start";
static NSString * const kEndDateKey = @"end";

@implementation PKTDateItemFieldValue

- (instancetype)initFromValueDictionary:(NSDictionary *)valueDictionary {
  self = [super init];
  if (!self) return nil;
  
  self.startDate = [NSDate pkt_dateFromUTCDateTimeString:valueDictionary[kStartDateKey]];
  self.endDate = [NSDate pkt_dateFromUTCDateTimeString:valueDictionary[kEndDateKey]];
  
  return self;
}

- (NSDictionary *)valueDictionary {
  return @{kStartDateKey : [self.startDate pkt_UTCDateTimeString],
           kEndDateKey : [self.endDate pkt_UTCDateTimeString]};
}

- (void)setUnboxedValue:(id)unboxedValue {
  self.startDate = unboxedValue[kStartDateKey];
  self.endDate =unboxedValue[kEndDateKey];
}

- (id)unboxedValue {
  return @{kStartDateKey : self.startDate,
           kEndDateKey : self.endDate};
}

+ (BOOL)supportsBoxingOfValue:(id)value {
  return [value isKindOfClass:[NSDictionary class]] &&
  [value[kStartDateKey] isKindOfClass:[NSDate class]] &&
  [value[kEndDateKey] isKindOfClass:[NSDate class]];
}

@end
