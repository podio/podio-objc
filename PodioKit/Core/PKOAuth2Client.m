//
//  PKOAuth2Client.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKOAuth2Client.h"
#import "NSDictionary+URL.h"

static const NSTimeInterval kRequestTimeout = 30;

@interface PKOAuth2Client ()

@property (nonatomic) PKOAuth2RequestType requestType;

@end

@implementation PKOAuth2Client

@synthesize delegate = delegate_;
@synthesize clientID = clientID_;
@synthesize clientSecret = clientSecret_;
@synthesize tokenURL = tokenURL_;
@synthesize requests = requests_;
@synthesize requestType = requestType_;

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret tokenURL:(NSString *)tokenURL {
  self = [super init];
  if (self) {
    clientID_ = [clientID copy];
    clientSecret_ = [clientSecret copy];
    tokenURL_ = [tokenURL copy];
    requests_ = nil;
    requestType_ = PKOAuth2RequestTypeNone;
    delegate_ = nil;
  }
  return self;
}

- (void)dealloc {
  delegate_ = nil;
}

// Lazy load
- (NSMutableSet *)requests {
  if (requests_ == nil) {
    requests_ = [[NSMutableSet alloc] init];
  }
  return requests_;
}

- (void)authenticateWithQueryParameters:(NSDictionary *)queryParameters postParameters:(NSDictionary *)postParameters postData:(NSData *)postData {
  PKAssert(self.clientID != nil, @"Client ID not configured.");
  PKAssert(self.clientSecret != nil, @"Client secret not configured.");
  PKAssert(self.tokenURL != nil, @"Token URL not configured.");
  
  @synchronized(self) {
    // Only allow one active request at a time
    if (self.requestType != PKOAuth2RequestTypeNone) return;
    
    NSString *urlString;
    if ([queryParameters count] > 0) {
      urlString = [NSString stringWithFormat:@"%@?%@", self.tokenURL, [queryParameters pk_escapedURLStringFromComponents]];
    } else {
      urlString = self.tokenURL;
    }
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:urlString]];
    request.delegate = self;
		request.requestMethod = @"POST";
    request.validatesSecureCertificate = YES;
    request.numberOfTimesToRetryOnTimeout = 2;
    request.timeOutSeconds = kRequestTimeout;
    
    if (postData) {
      [request appendPostData:postData];
    } else if (postParameters) {
      [postParameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [request setPostValue:obj forKey:key];
      }];
    }
    
    NSArray *languages = [NSLocale preferredLanguages];
    if ([languages count] > 0) {
      [request addRequestHeader:@"Accept-Language" value:[languages objectAtIndex:0]];
    }
		
    self.requestType = PKOAuth2RequestTypeAuthenticate;
		[self.requests addObject:request];
    
		[request startAsynchronous];
  }
}

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password {
  PKAssert(username != nil, @"Username cannot be nil.");
  PKAssert(password != nil, @"Password cannot be nil.");
  
  NSDictionary *postParams = @{@"grant_type": @"password",
                               @"client_id": self.clientID,
                               @"client_secret": self.clientSecret,
                               @"username": username,
                               @"password": password};
  
  [self authenticateWithQueryParameters:nil postParameters:postParams postData:nil];
}

- (void)authenticateWithGrantType:(NSString *)grantType body:(NSDictionary *)body {
  PKAssert(grantType != nil, @"Grant type cannot be nil.");
  
  NSDictionary *params = @{@"grant_type": grantType, @"client_id": self.clientID, @"client_secret": self.clientSecret};
  NSData *postData = [NSJSONSerialization dataWithJSONObject:body options:0 error:NULL];
  
  [self authenticateWithQueryParameters:params postParameters:nil postData:postData];
}

- (void)refreshUsingRefreshToken:(NSString *)refreshToken {
  PKAssert(self.clientID != nil, @"Client ID not configured.");
  PKAssert(self.clientSecret != nil, @"Client secret not configured.");
  PKAssert(self.tokenURL != nil, @"Token URL not configured.");
  PKAssert(refreshToken != nil, @"Refresh token cannot be nil.");
  
  @synchronized(self) {
    // Only allow one active request at a time
    if (self.requestType != PKOAuth2RequestTypeNone) return;
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:self.tokenURL]];
    request.delegate = self;
		request.requestMethod = @"POST";
    request.validatesSecureCertificate = YES;
    request.numberOfTimesToRetryOnTimeout = 2;
    request.timeOutSeconds = kRequestTimeout;
    
    [request setPostValue:@"refresh_token" forKey:@"grant_type"];
    [request setPostValue:self.clientID forKey:@"client_id"];
    [request setPostValue:self.clientSecret forKey:@"client_secret"];
    [request setPostValue:refreshToken forKey:@"refresh_token"];
    
    self.requestType = PKOAuth2RequestTypeRefreshToken;
		[self.requests addObject:request];
    
		[request startAsynchronous];
  }
}


- (void)requestFinished:(ASIHTTPRequest *)request {
  PKLogDebug(@"Authentication request finished with status code %d", [request responseStatusCode]);
  
  [self.requests removeObject:request];
  PKOAuth2RequestType requestType = self.requestType;
  self.requestType = PKOAuth2RequestTypeNone;
  
  id parsedData = nil;
  
  NSData *responseData = request.responseData;
  if ([responseData length] > 0) {
    NSError *error = nil;
    parsedData = [NSJSONSerialization JSONObjectWithData:responseData options:0 error:&error];
    
    if (!error) {
      PKLogDebug(@"Response body: %@", parsedData);
    } else {
      PKLogError(@"Failed to parse response data %@, %@", [error localizedDescription], [error userInfo]);
      return;
    }
  }
  
  if (request.responseStatusCode == 200) {
    // Got a new token
    NSString *accessToken = [parsedData objectForKey:@"access_token"];
    NSString *refreshToken = [parsedData objectForKey:@"refresh_token"];
    NSString *transferToken = [parsedData objectForKey:@"transfer_token"];
    
    NSTimeInterval expiresIn = [[parsedData objectForKey:@"expires_in"] intValue];
    NSDate *expiresOn = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
    
    NSDictionary *refData = [parsedData objectForKey:@"ref"];
    
    PKOAuth2Token *token = [PKOAuth2Token tokenWithAccessToken:accessToken 
                                                  refreshToken:refreshToken 
                                                 transferToken:transferToken 
                                                     expiresOn:expiresOn 
                                                       refData:refData];
    
    // Notify
    if (requestType == PKOAuth2RequestTypeAuthenticate) {
      if ([self.delegate respondsToSelector:@selector(oauthClient:didReceiveToken:)]) {
        [self.delegate oauthClient:self didReceiveToken:token];
      }
    } else if (requestType == PKOAuth2RequestTypeRefreshToken) {
      if ([self.delegate respondsToSelector:@selector(oauthClient:didReceiveToken:)]) {
        [self.delegate oauthClient:self didRefreshToken:token];
      }
    }
  } else if (requestType == PKOAuth2RequestTypeAuthenticate) {
    // Authentication failed
    if ([self.delegate respondsToSelector:@selector(oauthClientAuthenticationDidFail:responseData:)]) {
      [self.delegate oauthClientAuthenticationDidFail:self responseData:parsedData];
    }
  } else if (requestType == PKOAuth2RequestTypeRefreshToken) {
    // Refresh failed
    if ([self.delegate respondsToSelector:@selector(oauthClientTokenRefreshDidFail:)]) {
      [self.delegate oauthClientTokenRefreshDidFail:self];
    }
  }
}

- (void)requestFailed:(ASIHTTPRequest *)request {
  PKLogDebug(@"Authentication request failed with status code %d", [request responseStatusCode]);
  
  [self.requests removeObject:request];
  PKOAuth2RequestType requestType = self.requestType;
  self.requestType = PKOAuth2RequestTypeNone;
  
  if (requestType == PKOAuth2RequestTypeAuthenticate) {
    // Authentication failed
    if ([self.delegate respondsToSelector:@selector(oauthClientAuthenticationDidFail:responseData:)]) {
      [self.delegate oauthClientAuthenticationDidFail:self responseData:nil];
    }
  } else if (requestType == PKOAuth2RequestTypeRefreshToken) {
    // Refresh failed
    if ([self.delegate respondsToSelector:@selector(oauthClientTokenRefreshDidFail:)]) {
      [self.delegate oauthClientTokenRefreshDidFail:self];
    }
  }
}

@end
