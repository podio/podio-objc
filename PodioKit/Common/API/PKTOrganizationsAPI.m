//
//  PKTOrganizationsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTOrganizationsAPI.h"

@implementation PKTOrganizationsAPI

+ (PKTRequest *)requestForAllOrganizations {
  return [PKTRequest GETRequestWithPath:@"/org/" parameters:nil];
}

+ (PKTRequest *)requestForOrganizationWithID:(NSUInteger)organizationID {
  NSString *path = PKTRequestPath(@"/org/%lu", (unsigned long)organizationID);
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:nil];
  
  return request;
}

+ (PKTRequest *)requestToUpdateOrganizationWithID:(NSUInteger)organizationID withName:(NSString *)name {
  NSString *path = PKTRequestPath(@"/org/%lu", (unsigned long)organizationID);
  NSDictionary *parameters = @{@"name": name};
  PKTRequest *request = [PKTRequest PUTRequestWithPath:path parameters:parameters];
  
  return request;
}

@end
