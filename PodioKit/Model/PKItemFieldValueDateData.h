//
//  PKItemFieldValueDateData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-07.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKObjectData.h"

@class PKDate;

@interface PKItemFieldValueDateData : PKObjectData

@property (nonatomic, copy) PKDate *startDate;
@property (nonatomic, copy) PKDate *endDate;

- (NSDictionary *)valueDictionary;

@end
