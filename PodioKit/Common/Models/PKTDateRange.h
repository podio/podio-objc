//
//  PKTDateRange.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTDateRange : PKTModel

@property (nonatomic, copy) NSDate *startDate; // UTC start date
@property (nonatomic, copy) NSDate *endDate; // UTC end date
@property (nonatomic, assign) BOOL includesStartDateTimeComponent;
@property (nonatomic, assign) BOOL includesEndDateTimeComponent;

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (instancetype)rangeWithStartDate:(NSDate *)startDate;
+ (instancetype)rangeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
