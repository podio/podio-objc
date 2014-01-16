//
//  PKReferenceSpaceData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"
#import "PKReferenceOrganizationData.h"

@interface PKReferenceSpaceData : PKObjectData

@property (nonatomic) NSInteger spaceId;
@property (nonatomic) PKSpaceType type;
@property (nonatomic, copy) NSString *name;
@property (nonatomic) NSUInteger memberCount;
@property (nonatomic, strong) PKReferenceOrganizationData *organization;

@end
