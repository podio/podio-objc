//
//  PKTSessionManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTOAuth2Token.h"

typedef void(^PKTSessionAuthenticationBlock)(PKTOAuth2Token *token, NSError *error);

@interface PKTSessionManager : NSObject

@property (nonatomic, strong, readonly) PKTOAuth2Token *oauthToken;
@property (nonatomic, assign, readonly) BOOL isAuthenticated;

+ (instancetype)sharedManager;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTSessionAuthenticationBlock)completion;
- (void)authenticateWithAppID:(NSString *)appID token:(NSString *)appToken completion:(PKTSessionAuthenticationBlock)completion;

- (void)refreshSession:(PKTSessionAuthenticationBlock)completion;

@end
