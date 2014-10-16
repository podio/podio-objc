//
//  PKReferenceGrantData.h
//  PodioKit
//
//  Created by Romain Briche on 29/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"
#import "PKReferenceProfileData.h"

@interface PKReferenceGrantData : PKObjectData

@property (nonatomic, assign, readonly) NSUInteger grantId;
@property (nonatomic, strong, readonly) PKReferenceProfileData *grantedUser;

@end
