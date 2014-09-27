//
//  PKTDateRange.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 14/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTDateRange : PKTModel

@property (nonatomic, copy) NSDate *startDate;
@property (nonatomic, copy) NSDate *endDate;
@property (nonatomic, assign) BOOL includesTimeComponent;

- (instancetype)initWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

+ (instancetype)rangeWithStartDate:(NSDate *)startDate;
+ (instancetype)rangeWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
