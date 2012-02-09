//
//  PKOAuth2Client.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PKOAuth2Token.h"
#import "ASIHTTPRequest.h"


typedef enum {
  PKOAuth2RequestTypeNone = 0,
  PKOAuth2RequestTypeAuthenticate,
  PKOAuth2RequestTypeRefreshToken,
} PKOAuth2RequestType;

extern NSString * const PKOAuth2ClientDidReceiveAccessTokenNotification;
extern NSString * const PKOAuth2ClientFailedToReceiveTokenNotification;

@class PKOAuth2Client;

@protocol PKOAuth2ClientDelegate <NSObject>

@optional

- (void)oauthClient:(PKOAuth2Client *)oauthClient didReceiveToken:(PKOAuth2Token *)token;
- (void)oauthClient:(PKOAuth2Client *)oauthClient didRefreshToken:(PKOAuth2Token *)token;
- (void)oauthClientAuthenticationDidFail:(PKOAuth2Client *)oauthClient responseData:(id)responseData;
- (void)oauthClientTokenRefreshDidFail:(PKOAuth2Client *)oauthClient;

@end

@interface PKOAuth2Client : NSObject <ASIHTTPRequestDelegate> {
  
 @private
  NSString *clientID_;
  NSString *clientSecret_;
  NSString *tokenURL_;
  NSString *redirectURL_;
  
  NSMutableSet *requests_;
  PKOAuth2RequestType requestType_;
  
  id<PKOAuth2ClientDelegate> delegate_;
}

@property (nonatomic, copy) NSString *clientID;
@property (nonatomic, copy) NSString *clientSecret;
@property (nonatomic, copy) NSString *tokenURL;
@property (nonatomic, copy) NSString *redirectURL;
@property (nonatomic, readonly) NSMutableSet *requests;
@property (nonatomic, assign) id<PKOAuth2ClientDelegate> delegate;

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret tokenURL:(NSString *)tokenURL redirectURL:(NSString *)redirectURL;

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password;
- (void)refreshUsingRefreshToken:(NSString *)refreshToken;

@end
