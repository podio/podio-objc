//
//  PKUserAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/12/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKUserAPI.h"

@implementation PKUserAPI

+ (PKRequest *)requestForUserStatus {
  return [PKRequest requestWithURI:@"/user/status" method:PKRequestMethodGET];
}

+ (PKRequest *)requestForMobileNotificationSettings {
  return [PKRequest requestWithURI:@"/user/setting/mobile/" method:PKRequestMethodGET];
}

+ (PKRequest *)requestToSetMobileNotificationSettings:(NSDictionary *)settings {
  PKRequest *request = [PKRequest requestWithURI:@"/user/setting/mobile/" method:PKRequestMethodPUT];
  request.body = settings;
  
  return request;
}

@end
