//
//  PKItemFieldValueCalculationData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/29/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKItemFieldValueCalculationData : PKObjectData {

@private
  NSNumber *value_;
  NSString *unit_;
}

@property (nonatomic, copy) NSNumber *value;
@property (nonatomic, copy) NSString *unit;

@end
