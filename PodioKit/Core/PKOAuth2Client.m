//
//  PKOAuth2Client.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/14/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKOAuth2Client.h"
#import "ASIHTTPRequest.h"
#import "NSDictionary+URL.h"
#import "JSONKit.h"


@interface PKOAuth2Client ()

@property (nonatomic) PKOAuth2RequestType requestType;

@end

@implementation PKOAuth2Client

@synthesize clientID = clientID_;
@synthesize clientSecret = clientSecret_;
@synthesize tokenURL = tokenURL_;
@synthesize redirectURL = redirectURL_;
@synthesize requests = requests_;
@synthesize requestType = requestType_;
@synthesize delegate = delegate_;

- (id)initWithClientID:(NSString *)clientID clientSecret:(NSString *)clientSecret tokenURL:(NSString *)tokenURL redirectURL:(NSString *)redirectURL {
  self = [super init];
  if (self) {
    clientID_ = [clientID copy];
    clientSecret_ = [clientSecret copy];
    tokenURL_ = [tokenURL copy];
    redirectURL_ = [redirectURL copy];
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

- (void)authenticateWithUsername:(NSString *)username password:(NSString *)password {
  PKAssert(self.clientID != nil, @"Client ID not configured.");
  PKAssert(self.clientSecret != nil, @"Client secret not configured.");
  PKAssert(self.tokenURL != nil, @"Token URL not configured.");
  PKAssert(self.redirectURL != nil, @"Redirect URL not configured.");
  PKAssert(username != nil, @"Username cannot be nil.");
  PKAssert(password != nil, @"Password cannot be nil.");
  
  @synchronized(self) {
    // Only allow one active request at a time
    if (self.requestType != PKOAuth2RequestTypeNone) return;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"password" forKey:@"grant_type"];
		[params setValue:self.clientID forKey:@"client_id"];
		[params setValue:self.clientSecret forKey:@"client_secret"];
		[params setValue:[[NSURL URLWithString:self.redirectURL] absoluteString] forKey:@"redirect_uri"];
		[params setValue:username forKey:@"username"];
		[params setValue:password forKey:@"password"];
    
    NSString *queryString = [params pk_escapedURLStringFromComponents];
    NSString *requestURLString = [NSString stringWithFormat:@"%@?%@", self.tokenURL, queryString];
    PKLogDebug(@"Authentication URL: %@", requestURLString);
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURLString]]; 
    request.delegate = self;
		request.requestMethod = @"POST";
    request.validatesSecureCertificate = YES;
    request.numberOfTimesToRetryOnTimeout = 2;
    
    NSArray *languages = [NSLocale preferredLanguages];
    if ([languages count] > 0) {
      [request addRequestHeader:@"Accept-Language" value:[languages objectAtIndex:0]];
    }
		
    self.requestType = PKOAuth2RequestTypeAuthenticate;
		[self.requests addObject:request];
    
		[request startAsynchronous];
  }
}

- (void)refreshUsingRefreshToken:(NSString *)refreshToken {
  PKAssert(self.clientID != nil, @"Client ID not configured.");
  PKAssert(self.clientSecret != nil, @"Client secret not configured.");
  PKAssert(self.tokenURL != nil, @"Token URL not configured.");
  PKAssert(self.redirectURL != nil, @"Redirect URL not configured.");
  PKAssert(refreshToken != nil, @"Refresh token cannot be nil.");
  
  @synchronized(self) {
    // Only allow one active request at a time
    if (self.requestType != PKOAuth2RequestTypeNone) return;
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setValue:@"refresh_token" forKey:@"grant_type"];
		[params setValue:self.clientID forKey:@"client_id"];
		[params setValue:self.clientSecret forKey:@"client_secret"];
		[params setValue:[[NSURL URLWithString:self.redirectURL] absoluteString] forKey:@"redirect_uri"];
		[params setValue:refreshToken forKey:@"refresh_token"];
    
    NSString *queryString = [params pk_escapedURLStringFromComponents];
    NSString *requestURLString = [NSString stringWithFormat:@"%@?%@", self.tokenURL, queryString];
    PKLogDebug(@"Refresh URL: %@", requestURLString);
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:requestURLString]]; 
    request.delegate = self;
		request.requestMethod = @"POST";
    request.validatesSecureCertificate = YES;
    request.numberOfTimesToRetryOnTimeout = 2;
    
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
  
  NSError *error = nil;
  id parsedData = [[request responseData] objectFromJSONDataWithParseOptions:JKParseOptionNone error:&error];
  if (error != nil) {
    PKLogError(@"Failed to parse response data");
    return;
  }
  
  PKLogDebug(@"Response body: %@", parsedData);
  
  if (request.responseStatusCode == 200) {
    // Got a new token
    NSString *accessToken = [parsedData objectForKey:@"access_token"];
    NSString *refreshToken = [parsedData objectForKey:@"refresh_token"];
    NSString *transferToken = [parsedData objectForKey:@"transfer_token"];
    
    NSTimeInterval expiresIn = [[parsedData objectForKey:@"expires_in"] intValue];
    NSDate *expiresOn = [NSDate dateWithTimeIntervalSinceNow:expiresIn];
    
    PKOAuth2Token *token = [PKOAuth2Token tokenWithAccessToken:accessToken refreshToken:refreshToken transferToken:transferToken expiresOn:expiresOn];
    
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
