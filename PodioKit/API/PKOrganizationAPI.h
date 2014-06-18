//
//  PKOrganizationAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"


@interface PKOrganizationAPI : PKBaseAPI

+ (PKRequest *)requestForOrganizations;

+ (PKRequest *)requestToCreateOrganizationName:(NSString *)name;
+ (PKRequest *)requestToUpdateOrganizationWithId:(NSUInteger)organizationId name:(NSString *)name;
+ (PKRequest *)requestToGetAllSpacesInOrganizationWithId:(NSUInteger)organizationId;

@end
