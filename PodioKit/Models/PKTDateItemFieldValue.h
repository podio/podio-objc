//
//  PKTDateItemFieldValue.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemFieldValue.h"

@interface PKTDateItemFieldValue : PKTItemFieldValue

@property (nonatomic, copy) NSDate *startDate; // UTC start date
@property (nonatomic, copy) NSDate *endDate; // UTC end date

@end
