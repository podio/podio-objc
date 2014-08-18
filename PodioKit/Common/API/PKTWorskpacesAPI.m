//
//  PKTWorskpacesAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 18/08/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTWorskpacesAPI.h"

@implementation PKTWorskpacesAPI

+ (PKTRequest *)requestToCreateWorkspaceWithName:(NSString *)name organizationID:(NSUInteger)organizationID privacy:(PKTWorskpacePrivacy)privacy {
  NSParameterAssert(name);
  NSParameterAssert(organizationID > 0);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"name"] = name;
  params[@"org_id"] = @(organizationID);
  
  switch (privacy) {
    case PKTWorskpacePrivacyOpen:
      params[@"privacy"] = @"open";
      break;
    case PKTWorskpacePrivacyClosed:
      params[@"privacy"] = @"closed";
      break;
    default:
      break;
  }
  
  return [PKTRequest POSTRequestWithPath:@"/space/" parameters:params];
}

@end
