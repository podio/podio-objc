//
//  PKOAuth2Token.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKOAuth2Token.h"


static NSString * const PKOAuth2TokenAccessToken = @"AccessToken";
static NSString * const PKOAuth2TokenRefreshToken = @"RefreshToken";
static NSString * const PKOAuth2TokenTransferToken = @"TransferToken";
static NSString * const PKOAuth2TokenExpiresOn = @"ExpiresOn";

@implementation PKOAuth2Token

@synthesize accessToken = accessToken_;
@synthesize refreshToken = refreshToken_;
@synthesize transferToken = transferToken_;
@synthesize expiresOn = expiresOn_;

- (id)initWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken transferToken:(NSString *)transferToken expiresOn:(NSDate *)expiresOn {
  self = [super init];
  if (self) {
    accessToken_ = [accessToken copy];
    refreshToken_ = [refreshToken copy];
    transferToken_ = [transferToken copy];
    expiresOn_ = [expiresOn copy];
  }
  return self;
}

+ (id)tokenWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken transferToken:(NSString *)transferToken expiresOn:(NSDate *)expiresOn {
  return [[self alloc] initWithAccessToken:accessToken refreshToken:refreshToken transferToken:transferToken expiresOn:expiresOn];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    accessToken_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenAccessToken] copy];
    refreshToken_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenRefreshToken] copy];
    transferToken_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenTransferToken] copy];
    expiresOn_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenExpiresOn] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:accessToken_ forKey:PKOAuth2TokenAccessToken];
  [aCoder encodeObject:refreshToken_ forKey:PKOAuth2TokenRefreshToken];
  [aCoder encodeObject:transferToken_ forKey:PKOAuth2TokenTransferToken];
  [aCoder encodeObject:expiresOn_ forKey:PKOAuth2TokenExpiresOn];
}


- (BOOL)hasExpired {
  NSDate *safeCompareDate = [NSDate dateWithTimeIntervalSinceNow:10 * 60]; // If less than 10 minutes left, refresh
  return [self.expiresOn compare:safeCompareDate] == NSOrderedAscending;
}

@end
