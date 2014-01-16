//
//  PKShareCategoryData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKShareCategoryData : PKObjectData

@property (nonatomic) NSUInteger categoryId;
@property (nonatomic, copy) NSString *name;

@end
