//
//  NSDate+PKFormatting.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKFormatting)

+ (NSDate *)pk_dateFromUTCDateTimeString:(NSString *)dateTimeString;

+ (NSDate *)pk_dateFromUTCDateString:(NSString *)dateString;

- (NSString *)pk_UTCDateTimeString;

- (NSString *)pk_UTCDateString;

- (NSString *)pk_UTCTimeString;

@end
