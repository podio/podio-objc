//
//  PKDate+Formatting.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKDate+PKFormatting.h"
#import "NSDate+PKFormatting.h"

@implementation PKDate (PKFormatting)

#pragma mark - Public

+ (PKDate *)pk_dateFromUTCDateString:(NSString *)dateString {
  PKDate *date = nil;
  
  NSDate *parsedDate = [NSDate pk_dateFromUTCDateTimeString:dateString];
  if (parsedDate) {
    date = [PKDate dateWithDate:parsedDate includesTimeComponent:YES];
  } else {
    parsedDate = [NSDate pk_dateFromUTCDateString:dateString];
    if (parsedDate) {
      date = [PKDate dateWithDate:parsedDate includesTimeComponent:NO];
    }
  }
  
  return date;
}

- (NSString *)pk_UTCDateTimeString {
  return self.includesTimeComponent ? [self.date pk_UTCDateTimeString] : [self.date pk_UTCDateString];
}

- (NSString *)pk_UTCDateString {
  return [self.date pk_UTCDateString];
}

- (NSString *)pk_UTCTimeString {
  return self.includesTimeComponent ? [self.date pk_UTCTimeString] : nil;
}

@end
