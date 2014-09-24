//
//  NSDate+PKFormatting.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKFormatting)

+ (instancetype)pk_dateFromLocalDateTimeString:(NSString *)dateTimeString;

+ (instancetype)pk_dateFromLocalDateString:(NSString *)dateString;

+ (instancetype)pk_dateFromUTCDateTimeString:(NSString *)dateTimeString;

+ (instancetype)pk_dateFromUTCDateString:(NSString *)dateString;

- (NSString *)pk_localDateTimeString;

- (NSString *)pk_localDateString;

- (NSString *)pk_localTimeString;

- (NSString *)pk_UTCDateTimeString;

- (NSString *)pk_UTCDateString;

- (NSString *)pk_UTCTimeString;

@end
