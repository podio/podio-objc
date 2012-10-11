//
//  PKUserAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/12/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKUserAPI : PKBaseAPI

+ (PKRequest *)requestForUserStatus;

+ (PKRequest *)requestForMobileNotificationSettings;
+ (PKRequest *)requestToSetMobileNotificationSettings:(NSDictionary *)settings;

+ (PKRequest *)requestToCreateInactiveUserEmail:(NSString *)email locale:(NSString *)locale timeZone:(NSString *)timeZone options:(NSDictionary *)options;
+ (PKRequest *)requestToActivateUserWithActivationCode:(NSString *)activationCode name:(NSString *)name password:(NSString *)password;

+ (PKRequest *)requestToRecoverPasswordForEmail:(NSString *)email;

+ (PKRequest *)requestToUpdateProfileFieldWithKey:(NSString *)key value:(id)value;
+ (PKRequest *)requestToUpdateProfileAvatarWithFileId:(NSUInteger)fileId;

@end
