//
//  PKOAuth2Client.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOAuth2Token.h"
#import "ASIFormDataRequest.h"

typedef enum {
  PKOAuth2RequestTypeNone = 0,
  PKOAuth2RequestTypeAuthenticate,
  PKOAuth2RequestTypeRefreshToken,
} PKOAuth2RequestType;

@class PKOAuth2Client;

@protocol PKOAuth2ClientDelegate <NSObject>

@optional

- (void)oauthClient:(PKOAuth2Client *)oauthClient didReceiveToken:(PKOAuth2Token *)token;
- (void)oauthClient:(PKOAuth2Client *)oauthClient didRefreshToken:(PKOAuth2Token *)token;
- (void)oauthClientAuthenticationDidFail:(PKOAuth2Client *)oauthClient responseData:(id)responseData;
- (void)oauthClientTokenRefreshDidFail:(PKOAuth2Client *)oauthClient;

@end

@interface PKOAuth2Client : NSObject <ASIHTTPRequestDelegate>

@property (nonatomic, weak) id<PKOAuth2ClientDelegate> delegate;
@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, copy) NSString *tokenURL;
@property (nonatomic, readonly) NSMutableSet *requests;

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret tokenURL:(NSString *)tokenURL;

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password;
- (void)refreshUsingRefreshToken:(NSString *)refreshToken;

@end
