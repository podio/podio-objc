//
//  PKTNestedTestModel.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTNestedTestModel : PKTModel

@property (nonatomic, assign, readonly) NSUInteger objectID;
@property (nonatomic, copy, readonly) NSString *firstValue;

@end
