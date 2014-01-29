//
//  PKTSessionManager.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 27/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKTClient.h"

@class PKTOAuth2Token;

@interface PKTSessionManager : NSObject

@property (nonatomic, strong, readonly) PKTClient *client;
@property (nonatomic, strong, readonly) PKTOAuth2Token *oauthToken;
@property (nonatomic, assign, readonly) BOOL isAuthenticated;

+ (instancetype)sharedManager;

- (instancetype)initWithClient:(PKTClient *)client;

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKTRequestCompletionBlock)completion;
- (void)authenticateWithAppID:(NSString *)appID token:(NSString *)appToken completion:(PKTRequestCompletionBlock)completion;

- (void)refreshSessionToken:(PKTRequestCompletionBlock)completion;

@end
