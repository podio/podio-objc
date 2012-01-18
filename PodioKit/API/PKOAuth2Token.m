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
static NSString * const PKOAuth2TokenExpiresOn = @"ExpiresOn";

@implementation PKOAuth2Token

@synthesize accessToken = accessToken_;
@synthesize refreshToken = refreshToken_;
@synthesize expiresOn = expiresOn_;

- (id)initWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiresOn:(NSDate *)expiresOn {
  self = [super init];
  if (self) {
    accessToken_ = [accessToken copy];
    refreshToken_ = [refreshToken copy];
    expiresOn_ = [expiresOn copy];
  }
  return self;
}

+ (id)tokenWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiresOn:(NSDate *)expiresOn {
  return [[[self alloc] initWithAccessToken:accessToken refreshToken:refreshToken expiresOn:expiresOn] autorelease];
}


- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    accessToken_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenAccessToken] copy];
    refreshToken_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenRefreshToken] copy];
    expiresOn_ = [[aDecoder decodeObjectForKey:PKOAuth2TokenExpiresOn] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:accessToken_ forKey:PKOAuth2TokenAccessToken];
  [aCoder encodeObject:refreshToken_ forKey:PKOAuth2TokenRefreshToken];
  [aCoder encodeObject:expiresOn_ forKey:PKOAuth2TokenExpiresOn];
}

- (void)dealloc {
  [expiresOn_ release];
  [refreshToken_ release];
  [accessToken_ release];
  [super dealloc];
}

- (BOOL)hasExpired {
  NSDate *safeCompareDate = [NSDate dateWithTimeIntervalSinceNow:10 * 60]; // If less than 10 minutes left, refresh
  return [self.expiresOn compare:safeCompareDate] == NSOrderedAscending;
}

@end
