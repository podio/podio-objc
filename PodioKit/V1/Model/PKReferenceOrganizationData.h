//
//  PKReferenceOrganizationData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/12/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceOrganizationData : PKObjectData

@property (nonatomic, readonly) NSUInteger organizationId;
@property (nonatomic, copy, readonly) NSString *name;

@end
