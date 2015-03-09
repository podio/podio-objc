//
//  PKTOAuth2Token.h
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTOAuth2Token : PKTModel

/**
 *  The access token used for API access.
 */
@property (nonatomic, copy, readonly) NSString *accessToken;

/**
 *  The refresh token used to refresh the access token. This is managed automatically by the PKTClient.
 */
@property (nonatomic, copy, readonly) NSString *refreshToken;

/**
 *  The transfer token.
 */
@property (nonatomic, copy, readonly) NSString *transferToken;

/**
 *  The date representing the point in time at which the token will expire.
 */
@property (nonatomic, copy, readonly) NSDate *expiresOn;

/**
 *  Additional meta data related to the logged in entity (usually a user or an app).
 */
@property (nonatomic, copy, readonly) NSDictionary *refData;

/**
 *  Convenience initiatlizer to create a token from the raw token components.
 *
 *  @param accessToken   The access token
 *  @param refreshToken  The refresh token
 *  @param transferToken The transfer token
 *  @param expiresOn     The date when the token expires
 *  @param refData       The reference data
 *
 *  @return A new auth token.
 */
- (instancetype)initWithAccessToken:(NSString *)accessToken
                       refreshToken:(NSString *)refreshToken
                      transferToken:(NSString *)transferToken
                          expiresOn:(NSDate *)expiresOn
                            refData:(NSDictionary *)refData;

/**
 *  Convenience method to check whether or not the token will expire within the provided interval.
 *
 *  @param expireInterval A time interval from now.
 *
 *  @return YES if the token will expire within the provided time interval, otherwise NO.
 */
- (BOOL)willExpireWithinIntervalFromNow:(NSTimeInterval)expireInterval;

@end
