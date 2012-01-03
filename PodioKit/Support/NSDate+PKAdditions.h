//
//  NSDate+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKAdditions)

+ (NSDate *)pk_dateWithString:(NSString *)dateString formatString:(NSString *)formatString;

+ (NSDate *)pk_dateWithDateString:(NSString*)dateString;

+ (NSDate *)pk_dateWithDateTimeString:(NSString*)dateString;

+ (NSDate *)pk_localDateFromUTCDateString:(NSString *)dateString;

- (NSDate *)pk_localDateFromUTCDate;

- (NSDate *)pk_UTCDateFromLocalDate;

- (NSString *)pk_dateTimeStringWithFormatString:(NSString *)formatString;

- (NSString *)pk_dateString;

- (NSString *)pk_dateTimeString;

@end
