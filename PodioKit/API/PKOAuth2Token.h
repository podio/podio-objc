//
//  PKOAuth2Token.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKOAuth2Token : NSObject <NSCoding> {
  
@private
  NSString *accessToken_;
  NSString *refreshToken_;
  NSDate *expiresOn_;
}

@property (nonatomic, readonly) NSString *accessToken;
@property (nonatomic, readonly) NSString *refreshToken;
@property (nonatomic, readonly) NSDate *expiresOn;

- (id)initWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiresOn:(NSDate *)expiresOn;
+ (id)tokenWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken expiresOn:(NSDate *)expiresOn;

- (BOOL)hasExpired;

@end
