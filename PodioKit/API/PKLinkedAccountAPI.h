//
//  PKLinkedAccountAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/28/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKLinkedAccountAPI : PKBaseAPI

+ (PKRequest *)requestForLinkedAccountsWithCapability:(PKProviderCapability)capability;
+ (PKRequest *)requestForProvidersWithCapability:(PKProviderCapability)capability;

@end
