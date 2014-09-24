//
//  NSDate+PKFormatting.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKFormatting)

+ (NSDate *)pk_dateFromLocalDateTimeString:(NSString *)dateTimeString;

+ (NSDate *)pk_dateFromLocalDateString:(NSString *)dateString;

+ (NSDate *)pk_dateFromUTCDateTimeString:(NSString *)dateTimeString;

+ (NSDate *)pk_dateFromUTCDateString:(NSString *)dateString;

- (NSString *)pk_localDateTimeString;

- (NSString *)pk_localDateString;

- (NSString *)pk_localTimeString;

- (NSString *)pk_UTCDateTimeString;

- (NSString *)pk_UTCDateString;

- (NSString *)pk_UTCTimeString;

@end
