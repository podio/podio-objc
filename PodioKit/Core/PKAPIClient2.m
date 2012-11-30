//
//  PKAPIClient2.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/29/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAPIClient2.h"
#import "PKHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "PKOAuth2Token.h"
#import "NSError+PKErrors.h"

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";

@interface PKAPIClient2 ()

@property (nonatomic, strong) PKOAuth2Token *oauthToken;
@property (nonatomic, strong) NSMutableArray *pendingOperations;

@end

@implementation PKAPIClient2

+ (id)sharedClient {
  static id sharedClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kDefaultBaseURLString]];
  });
  
  return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
  @synchronized(self) {
    self = [super initWithBaseURL:url];
    if (self) {
      [self registerHTTPOperationClass:[PKHTTPRequestOperation class]];
      [self updateDefaultHeaders];
    }
    
    return self;
  }
}

- (id)initWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret {
  self = [self initWithBaseURL:[NSURL URLWithString:kDefaultBaseURLString]];
  if (self) {
    _apiKey = [apiKey copy];
    _apiSecret = [apiSecret copy];
  }
  return self;
}


#pragma mark - Properties

- (void)setUserAgent:(NSString *)userAgent {
  _userAgent = [userAgent copy];
  [self updateDefaultHeaders];
}

- (void)setOauthToken:(PKOAuth2Token *)oauthToken {
  _oauthToken = oauthToken;
  [self updateDefaultHeaders];
  
  if (!oauthToken) {
    [self cancelPendingOperations];
  }
}

- (NSMutableArray *)pendingOperations {
  @synchronized(self) {
    if (!_pendingOperations) {
      _pendingOperations = [[NSMutableArray alloc] init];
    }
    
    return _pendingOperations;
  }
}

#pragma mark - Misc

- (void)updateDefaultHeaders {
  [self setDefaultHeader:@"User-Agent" value:self.userAgent];
  
  NSArray *languages = [NSLocale preferredLanguages];
  NSString *language = [languages count] > 0 ? languages[0] : nil;
  [self setDefaultHeader:@"Accept-Language" value:language];
  
  if (self.oauthToken) {
    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"OAuth2 %@", self.oauthToken.accessToken]];
  } else {
    [self setAuthorizationHeaderWithUsername:self.apiKey password:self.apiSecret];
  }
}

#pragma mark - Authentication

- (BOOL)isAuthenticated {
  return self.oauthToken != nil;
}

- (void)authenticateWithPostBody:(NSDictionary *)postBody completion:(PKRequestCompletionBlock)completion {
  @synchronized(self) {
    PKAssert(self.apiKey != nil, @"Missing API key.");
    PKAssert(self.apiSecret != nil, @"Missing API secret.");
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:postBody];
    body[@"client_id"] = self.apiKey;
    body[@"client_secret"] = self.apiSecret;

    NSURLRequest *request = [self requestWithMethod:@"POST" path:@"/oauth/token" parameters:body];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
      
      if (response.statusCode == 200) {
        self.oauthToken = [PKOAuth2Token tokenFromDictionary:JSON];
        [self retryPendingOperations];
      } else {
        self.oauthToken = nil;
      }
      
      if (completion) {
        completion(nil, nil);
      }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
      [self cancelPendingOperations];
      
      if (completion) {
        completion(error, nil);
      }
    }];
  
    [self enqueueHTTPRequestOperation:operation];
  }
}

- (void)authenticateWithGrantType:(NSString *)grantType body:(NSDictionary *)body completion:(PKRequestCompletionBlock)completion {
  PKAssert(grantType != nil, @"Missing grant type.");
  
  NSMutableDictionary *grantBody = [[NSMutableDictionary alloc] initWithDictionary:body];
  grantBody[@"grant_type"] = grantType;
  
  [self authenticateWithPostBody:grantBody completion:completion];
}

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password completion:(PKRequestCompletionBlock)completion {
  PKAssert(email != nil, @"Missing email.");
  PKAssert(password != nil, @"Missing password.");
  
  [self authenticateWithGrantType:@"password" body:@{@"username": email, @"password": password} completion:completion];
}

- (void)refreshOAuthTokenWithRefreshToken:(NSString *)refreshToken completion:(PKRequestCompletionBlock)completion {
  PKAssert(refreshToken != nil, @"Missing refresh token.");
  
  [self authenticateWithGrantType:@"refresh_token" body:@{@"refresh_token": refreshToken} completion:completion];
}

- (void)refreshOAuthToken {
  if (!self.oauthToken) {
    PKLogWarn(@"Can't refresh, missing existing token.");
    return;
  }
  
  [self refreshOAuthTokenWithRefreshToken:self.oauthToken.refreshToken completion:nil];
}

#pragma mark - Operations

- (PKHTTPRequestOperation *)operationWithRequest:(NSURLRequest *)request completion:(PKRequestCompletionBlock)completion {
  PKHTTPRequestOperation *operation = (PKHTTPRequestOperation *)[self HTTPRequestOperationWithRequest:request success:nil failure:nil];
  operation.requestCompletionBlock = completion;
  
  return operation;
}

- (BOOL)performOperation:(PKHTTPRequestOperation *)operation {
  if (![self isAuthenticated]) {
    operation.requestCompletionBlock([NSError pk_notAuthenticatedError], nil);
    return NO;
  }
  
  if (![self.oauthToken hasExpired]) {
    [self enqueueHTTPRequestOperation:operation];
  } else {
    // Token expired, keep request until token is refreshed
    [self.pendingOperations addObject:operation];
    [self refreshOAuthToken];
  }
  
  return YES;
}

- (void)retryPendingOperations {
  for (PKHTTPRequestOperation *operation in self.pendingOperations) {
    // Update authorization header in case the token changed, e.g. due to a refresh
    [operation setValue:[self defaultValueForHeader:@"Authorization"] forHeader:@"Authorization"];
    [self enqueueHTTPRequestOperation:operation];
  }
  
  [self.pendingOperations removeAllObjects];
}

- (void)cancelPendingOperations {
  for (PKHTTPRequestOperation *operation in self.pendingOperations) {
    [operation cancel];
  }
  
  [self.pendingOperations removeAllObjects];
}

@end
