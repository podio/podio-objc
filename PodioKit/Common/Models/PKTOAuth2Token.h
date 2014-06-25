//
//  PKTOAuth2Token.h
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@interface PKTOAuth2Token : PKTModel

@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, copy, readonly) NSDate *expiresOn;
@property (nonatomic, copy, readonly) NSDictionary *refData;

- (BOOL)willExpireWithinIntervalFromNow:(NSTimeInterval)expireInterval;

@end
