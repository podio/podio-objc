//
//  PKReferenceProfileData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/1/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@class PKFileData;

@interface PKReferenceProfileData : PKObjectData

@property (nonatomic) NSInteger profileId;
@property (nonatomic) NSInteger userId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) PKReferenceType type;
@property (nonatomic) NSInteger avatarId;
@property (nonatomic, strong) PKFileData *image;
@property (nonatomic, assign) BOOL removable;

@end
