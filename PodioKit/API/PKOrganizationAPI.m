//
//  PKOrganizationAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKOrganizationAPI.h"


@implementation PKOrganizationAPI

+ (PKRequest *)requestForOrganizations {
  return [PKRequest requestWithURI:@"/org/" method:PKAPIRequestMethodGET];
}

@end
