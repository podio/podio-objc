//
//  PKOrganizationAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/17/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKBaseAPI.h"


@interface PKOrganizationAPI : PKBaseAPI

+ (PKRequest *)requestForOrganizations;

@end
