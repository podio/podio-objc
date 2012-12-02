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

+ (PKRequest *)requestToCreateInactiveUserEmail:(NSString *)email locale:(NSString *)locale timeZone:(NSString *)timeZone options:(NSDictionary *)options {
  PKRequest *request = [PKRequest requestWithURI:@"/user/inactive/" method:PKRequestMethodPOST];
  
  request.body = [NSMutableDictionary dictionary];
  [request.body setObject:email forKey:@"mail"];
  [request.body setObject:locale forKey:@"locale"];
  [request.body setObject:timeZone forKey:@"timezone"];
  
  if ([options count] > 0) {
    [request.body addEntriesFromDictionary:options];
  }
  
  return request;
}

+ (PKRequest *)requestForActivationStatusWithCode:(NSString *)activationCode {
  PKRequest *request = [PKRequest requestWithURI:@"/user/status/activation" method:PKRequestMethodGET];
  request.parameters[@"activation_code"] = activationCode;
  
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

+ (PKRequest *)requestToRecoverPasswordForEmail:(NSString *)email {
  PKRequest *request = [PKRequest requestWithURI:@"/user/recover_password" method:PKRequestMethodPOST];
  request.body = @{@"mail": email};
  
  return request;
}

+ (PKRequest *)requestToUpdateProfileFieldWithKey:(NSString *)key value:(id)value {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/user/profile/%@", key] method:PKRequestMethodPUT];
  request.body = @{@"value": value};
  
  return request;
}

+ (PKRequest *)requestToUpdateProfileAvatarWithFileId:(NSUInteger)fileId {
  return [self requestToUpdateProfileFieldWithKey:@"avatar" value:@(fileId)];
}

@end