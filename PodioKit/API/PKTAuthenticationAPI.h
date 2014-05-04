//
//  PKTAuthenticationAPI.h
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTBaseAPI.h"

@interface PKTAuthenticationAPI : PKTBaseAPI

+ (PKTRequest *)requestForAuthenticationWithEmail:(NSString *)email password:(NSString *)password;

+ (PKTRequest *)requestForAuthenticationWithAppID:(NSUInteger)appID token:(NSString *)appToken;

+ (PKTRequest *)requestToRefreshToken:(NSString *)refreshToken;

@end
