//
//  PKTCategoryOption 
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/05/14
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"
#import "PKTConstants.h"

@interface PKTCategoryOption : PKTModel

@property (nonatomic, assign, readonly) NSUInteger optionID;
@property (nonatomic, assign, readonly) PKTCategoryOptionStatus status;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *color;

@end