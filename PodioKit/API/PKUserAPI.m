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

+ (PKRequest *)requestToCreateInactiveUserEmail:(NSString *)email locale:(NSString *)locale options:(NSDictionary *)options {
  PKRequest *request = [PKRequest requestWithURI:@"/user/inactive/" method:PKRequestMethodPOST];
  request.requiresAuthenticated = NO;
  
  request.body = [NSMutableDictionary dictionary];
  [request.body setObject:email forKey:@"mail"];
  [request.body setObject:locale forKey:@"locale"];
  
  if ([options count] > 0) {
    [request.body addEntriesFromDictionary:options];
  }
  
  return request;
}

+ (PKRequest *)requestToActivateUserWithActivationCode:(NSString *)activationCode name:(NSString *)name password:(NSString *)password {
  PKRequest *request = [PKRequest requestWithURI:@"/user/activate_user" method:PKRequestMethodPOST];
  request.requiresAuthenticated = NO;
  request.body = @{
    @"activation_code": activationCode,
    @"name": name,
    @"password": password,
  };
  
  return request;
}

@end