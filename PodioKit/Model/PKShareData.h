//
//  PKShareData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKShareData : PKObjectData

@property (nonatomic) NSUInteger shareId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic) NSInteger rating;
@property (nonatomic, copy) NSArray *children; // PKShareData objects

@end
