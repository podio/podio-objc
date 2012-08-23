//
//  PKOAuth2Token.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKOAuth2Token : NSObject <NSCoding>

@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, copy, readonly) NSString *transferToken;
@property (nonatomic, copy, readonly) NSDate *expiresOn;
@property (nonatomic, copy, readonly) NSDictionary *refData;

- (id)initWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken transferToken:(NSString *)transferToken expiresOn:(NSDate *)expiresOn refData:(NSDictionary *)refData;
+ (id)tokenWithAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken transferToken:(NSString *)transferToken expiresOn:(NSDate *)expiresOn refData:(NSDictionary *)refData;

- (BOOL)hasExpired;

@end
