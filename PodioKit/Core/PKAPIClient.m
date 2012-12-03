//
//  PKAPIClient2.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/29/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAPIClient.h"
#import "PKHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "PKOAuth2Token.h"
#import "NSError+PKErrors.h"

// Notifications
NSString * const PKAPIClientWillBeginAuthentication = @"PKAPIClientWillBeginAuthentication";
NSString * const PKAPIClientDidFinishAuthentication = @"PKAPIClientDidFinishAuthentication";

NSString * const PKAPIClientWillBeginReauthentication = @"PKAPIClientWillBeginReauthentication";
NSString * const PKAPIClientDidFinishReauthentication = @"PKAPIClientDidFinishReauthentication";

NSString * const PKAPIClientDidAuthenticateUser = @"PKAPIClientDidAuthenticateUser";
NSString * const PKAPIClientAuthenticationFailed = @"PKAPIClientAuthenticationFailed";
NSString * const PKAPIClientReauthenticationFailed = @"PKAPIClientReauthenticationFailed";

NSString * const PKAPIClientWillRefreshAccessToken = @"PKAPIClientWillRefreshAccessToken";
NSString * const PKAPIClientDidRefreshAccessToken = @"PKAPIClientDidRefreshAccessToken";

NSString * const PKAPIClientTokenRefreshFailed = @"PKAPIClientTokenRefreshFailed";
NSString * const PKAPIClientNeedsReauthentication = @"PKAPIClientNeedsReauthentication";

// Notification user info keys
NSString * const PKAPIClientTokenKey = @"Token";
NSString * const PKAPIClientErrorKey = @"Error";

static NSString * const kDefaultBaseURLString = @"https://api.podio.com";
static NSString * const kDefaultFileUploadURLString = @"https://files.podio.com";

@interface PKAPIClient ()

@property (nonatomic) NSURL *baseURL;
@property (nonatomic, strong) NSMutableArray *pendingOperations;
@property BOOL isRefreshing;

@end

@implementation PKAPIClient

+ (PKAPIClient *)sharedClient {
  static id sharedClient;
  static dispatch_once_t once;
  
  dispatch_once(&once, ^{
    sharedClient = [[self alloc] initWithAPIKey:nil apiSecret:nil];
  });
  
  return sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
  @synchronized(self) {
    self = [super initWithBaseURL:url];
    if (self) {
      _uploadURLString = [kDefaultFileUploadURLString copy];
      
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

- (void)configureWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret {
  @synchronized(self) {
    self.apiKey = apiKey;
    self.apiSecret = apiSecret;
  }
}

#pragma mark - Properties

- (void)setBaseURLString:(NSString *)baseURLString {
  @synchronized(self) {
    _baseURLString = [baseURLString copy];
    self.baseURL = [NSURL URLWithString:baseURLString];
  }
}

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
    
    if (self.isRefreshing) {
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillRefreshAccessToken object:self];
    } else {
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillBeginAuthentication object:self];
    }
    
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:postBody];
    body[@"client_id"] = self.apiKey;
    body[@"client_secret"] = self.apiSecret;

    NSURLRequest *request = [self requestWithMethod:@"POST" path:@"/oauth/token" parameters:body];
    NSMutableURLRequest *mutRequest = [request mutableCopy];
    [mutRequest setValue:nil forHTTPHeaderField:@"Authorization"];
    
    PKHTTPRequestOperation *operation = [PKHTTPRequestOperation operationWithRequest:mutRequest completion:^(NSError *error, PKRequestResult *result) {
      
      if (!error) {
        self.oauthToken = [PKOAuth2Token tokenFromDictionary:result.parsedData];
        [self retryPendingOperations];
        
        if (self.isRefreshing) {
          NSDictionary *userInfo = @{PKAPIClientTokenKey: self.oauthToken};
          [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidRefreshAccessToken
                                                              object:self userInfo:userInfo];
        } else {
          [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidFinishAuthentication object:self];
          
          NSDictionary *userInfo = self.oauthToken ? @{PKAPIClientTokenKey: self.oauthToken} : nil;
          [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidAuthenticateUser object:self userInfo:userInfo];
        }
      } else {
        [self cancelPendingOperations];
        
        NSDictionary *userInfo = @{PKAPIClientErrorKey: error};
        
        if (self.isRefreshing) {
          [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientTokenRefreshFailed object:self userInfo:userInfo];
          
          if ([error.domain isEqualToString:PKPodioKitErrorDomain] && error.code == PKErrorCodeServerError) {
            // Error from server, re-authenticate
            self.oauthToken = nil;
            [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNeedsReauthentication object:self];
          }
        } else {
          [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidFinishAuthentication object:self];
          [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientAuthenticationFailed object:self userInfo:userInfo];
        }
      }
      
      if (completion) {
        completion(nil, nil);
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
  
  self.isRefreshing = YES;
  [self authenticateWithGrantType:@"refresh_token" body:@{@"refresh_token": refreshToken} completion:^(NSError *error, PKRequestResult *result) {
    self.isRefreshing = NO;
  }];
}

- (void)refreshOAuthToken {
  if (!self.oauthToken) {
    PKLogWarn(@"Can't refresh, missing existing token.");
    return;
  }
  
  [self refreshOAuthTokenWithRefreshToken:self.oauthToken.refreshToken completion:nil];
}

#pragma mark - Requests

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                      path:(NSString *)path
                                parameters:(NSDictionary *)parameters
                                      body:(id)body {
  
  
  NSMutableURLRequest *request = [super requestWithMethod:method path:path parameters:nil];
  if ([parameters count] > 0) {
    request.URL = [NSURL URLWithString:[[request.URL absoluteString] stringByAppendingFormat:@"?%@", AFQueryStringFromParametersWithEncoding(parameters, self.stringEncoding)]];
  }
  
  if (body && ![method isEqualToString:PKRequestMethodGET] && ![method isEqualToString:PKRequestMethodDELETE]) {
    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(self.stringEncoding));
    NSError *error = nil;
    
    [request setValue:[NSString stringWithFormat:@"application/json; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[NSJSONSerialization dataWithJSONObject:body options:0 error:&error]];
    
    if (error) {
      PKLogError(@"Failed to serialize body to JSON, %@", [error localizedDescription]);
    }
  }
  
  return request;
}

- (NSMutableURLRequest *)uploadRequestWithBodyConstructionBlock:(void (^)(id <AFMultipartFormData> formData))constructionBlock {
  NSMutableURLRequest *request = [self multipartFormRequestWithMethod:PKRequestMethodPOST path:@"/file/" parameters:nil constructingBodyWithBlock:constructionBlock];
  
  return request;
}

- (NSMutableURLRequest *)uploadRequestWithFilePath:(NSString *)path fileName:(NSString *)fileName {
  return [self uploadRequestWithBodyConstructionBlock:^(id<AFMultipartFormData> formData) {
    NSError *error = nil;
    [formData appendPartWithFileURL:[NSURL URLWithString:path] name:fileName error:&error];
    if (error) {
      PKLogError(@"Failed to construct request to upload file at path %@", path);
    }
  }];
}

- (NSMutableURLRequest *)uploadRequestWithData:(NSData *)data fileName:(NSString *)fileName {
  return [self uploadRequestWithBodyConstructionBlock:^(id<AFMultipartFormData> formData) {
    [formData appendPartWithFormData:data name:fileName];
  }];
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
