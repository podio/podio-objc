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

+ (PKRequest *)requestToCreateInactiveUserEmail:(NSString *)email {
  PKRequest *request = [PKRequest requestWithURI:@"/user/inactive/" method:PKRequestMethodPOST];
  request.body = @{@"mail": email};
  
  return request;
}

+ (PKRequest *)requestToActivateUserWithActivationCode:(NSString *)activationCode name:(NSString *)name password:(NSString *)password {
  PKRequest *request = [PKRequest requestWithURI:@"/user/activate_user" method:PKRequestMethodPOST];
  request.body = @{
    @"activation_code": activationCode,
    @"name": name,
    @"password": password,
  };
  
  return request;
}

@end