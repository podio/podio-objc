//
//  PKTOAuth2Token.m
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTOAuth2Token.h"

static NSString * const kOAuth2AccessTokenKey = @"access_token";
static NSString * const kOAuth2RefreshTokenKey = @"refresh_token";
static NSString * const kOAuth2ExpiresOnKey = @"expires_in";
static NSString * const kOAuth2RefDataKey = @"ref";

@implementation PKTOAuth2Token

- (instancetype)initWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiresOn:(NSDate *)expiresOn refData:(NSDictionary *)refData {
  self = [super init];
  if (!self) return nil;

  _accessToken = [accessToken copy];
  _refreshToken = [refreshToken copy];
  _expiresOn = [expiresOn copy];
  _refData = [refData copy];

  return self;
}

+ (instancetype)tokenFromDictionary:(NSDictionary *)dictionary {
  NSParameterAssert(dictionary);
  return [[self alloc] initWithAccessToken:dictionary[kOAuth2AccessTokenKey]
                              refreshToken:dictionary[kOAuth2RefreshTokenKey]
                                 expiresOn:[NSDate dateWithTimeIntervalSinceNow:[dictionary[kOAuth2ExpiresOnKey] doubleValue]]
                                   refData:dictionary[kOAuth2RefDataKey]];
}

@end
