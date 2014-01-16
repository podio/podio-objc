//
//  PKProviderData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/1/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKProviderData : PKObjectData

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *humanizedName;
@property (nonatomic, copy) NSString *connectLink;

@end
