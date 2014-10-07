//
//  NSDate+PKAdditions.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PKAdditions)

- (NSDate *)pk_convertedDateInCurrentCalendarToCurrentTimeZoneFromUTC;

- (NSDate *)pk_convertedDateInCurrentCalendarToUTCFromCurrentTimeZone;

- (NSDate *)pk_convertedDateInCalendar:(NSCalendar *)calendar fromTimeZone:(NSTimeZone *)fromTimeZone toTimeZone:(NSTimeZone *)toTimeZone;

@end
