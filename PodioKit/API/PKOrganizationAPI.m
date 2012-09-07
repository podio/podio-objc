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
  return [PKRequest requestWithURI:@"/org/" method:PKRequestMethodGET];
}

+ (PKRequest *)requestToCreateOrganizationName:(NSString *)name {
  PKRequest *request = [PKRequest requestWithURI:@"/org/" method:PKRequestMethodPOST];
  request.body = @{@"name": name};
  
  return request;
}

+ (PKRequest *)requestToUpdateOrganizationWithId:(NSUInteger)organizationId name:(NSString *)name {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/org/%d", organizationId] method:PKRequestMethodPUT];
  request.body = @{@"name": name};
  
  return request;
}

@end
