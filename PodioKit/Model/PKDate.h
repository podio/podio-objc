//
//  PKDate.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 21/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  PKDate is similar to an NSDate but the time component is optional. When there is no time component,
 *  PKDates that have the same "day" component (year+month+day) in UTC, are considered equal. If there is a time
 *  component, the date will be treated as a normal NSDate.
 */
@interface PKDate : NSDate

/**
 *  Indicates whether or not the date has a time component.
 */
@property (nonatomic, assign, readonly) BOOL includesTimeComponent;

/**
 *  Initialize a date with an existing NSDate. If includesTimeComponent is NO, the intervalSinceReferenceDate will
 *  represent the beginning of the UTC date.
 *
 *  @param date                  The existing date
 *  @param includesTimeComponent A BOOL indicating whether or not to consider the time component of the date
 *
 *  @return A new date
 */
+ (instancetype)dateWithDate:(NSDate *)date includesTimeComponent:(BOOL)includesTimeComponent;

/**
 *  Returns a date representing today (in UTC), without a time component.
 *
 *  @return A new date
 */
+ (instancetype)dateWithoutTimeComponent;

/**
 *  Makes a copy of an existing date but discards the time component.
 *
 *  @return A new date
 */
- (instancetype)copyWithoutTimeComponent;

@end