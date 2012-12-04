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
#import "NSURLRequest+PKDescription.h"

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
@property (strong) id requestFailedObserver;

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
      
      // If any request receives a 401, we need to rauthenticate
      _requestFailedObserver = [[NSNotificationCenter defaultCenter] addObserverForName:PKHTTPRequestOperationFailed
                                                                                 object:nil
                                                                                  queue:[NSOperationQueue mainQueue]
                                                                             usingBlock:^(NSNotification *note) {
        PKHTTPRequestOperation *operation = [note.userInfo objectForKey:PKHTTPRequestOperationKey];
        if ([[self.operationQueue operations] containsObject:operation] && operation.response.statusCode == 401) {
          [self needsAuthentication];
        }
      }];
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

- (void)dealloc {
  if (_requestFailedObserver) {
    [[NSNotificationCenter defaultCenter] removeObserver:_requestFailedObserver];
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

#pragma mark - Configuration

- (void)configureWithAPIKey:(NSString *)apiKey apiSecret:(NSString *)apiSecret {
  @synchronized(self) {
    self.apiKey = apiKey;
    self.apiSecret = apiSecret;
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

#pragma mark - Events

- (void)willAuthenticate {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillBeginAuthentication object:self];
  });
}

- (void)didAuthenticateWithToken:(PKOAuth2Token *)token error:(NSError *)error {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidFinishAuthentication object:self];
    
    if (!error) {
      NSDictionary *userInfo = token ? @{PKAPIClientTokenKey: token} : nil;
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidAuthenticateUser object:self userInfo:userInfo];
    } else {
      NSDictionary *userInfo = @{PKAPIClientErrorKey: error};
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientAuthenticationFailed object:self userInfo:userInfo];
    }
  });
}

- (void)willRefreshToken {
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillRefreshAccessToken object:self];
  });
}

- (void)didRefreshToken:(PKOAuth2Token *)token error:(NSError *)error {
  dispatch_async(dispatch_get_main_queue(), ^{
    if (!error) {
      NSDictionary *userInfo = token ? @{PKAPIClientTokenKey: token} : nil;
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidRefreshAccessToken object:self userInfo:userInfo];
    } else {
      NSDictionary *userInfo = @{PKAPIClientErrorKey: error};
      [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientTokenRefreshFailed object:self userInfo:userInfo];
      
      if ([error.domain isEqualToString:PKPodioKitErrorDomain] && error.code == PKErrorCodeServerError) {
        // Error from server, re-authenticate
        [self needsAuthentication];
      }
    }
  });
}

#pragma mark - Authentication

- (BOOL)isAuthenticated {
  return self.oauthToken != nil;
}

- (void)needsAuthentication {
  self.oauthToken = nil;
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNeedsReauthentication object:self];
  });
}

- (void)authenticateWithPostBody:(NSDictionary *)postBody completion:(PKRequestCompletionBlock)completion {
  @synchronized(self) {
    PKAssert(self.apiKey != nil, @"Missing API key.");
    PKAssert(self.apiSecret != nil, @"Missing API secret.");
    
    if (self.isRefreshing) {
      [self willRefreshToken];
    } else {
      [self willAuthenticate];
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
          [self didRefreshToken:self.oauthToken error:nil];
        } else {
          [self didAuthenticateWithToken:self.oauthToken error:nil];
        }
      } else {
        [self cancelPendingOperations];
        
        if (self.isRefreshing) {
          [self didRefreshToken:nil error:error];
        } else {
          [self didAuthenticateWithToken:nil error:error];
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
  
  request.HTTPShouldUsePipelining = YES;
  
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
  [operation setRequestCompletionBlock:completion];
  
  return operation; 
}

- (BOOL)performOperation:(PKHTTPRequestOperation *)operation {
  if (![self isAuthenticated]) {
    [operation completeWithResult:nil error:[NSError pk_notAuthenticatedError]];
    return NO;
  }
  
  if (![self.oauthToken hasExpired]) {
    PKLogDebug(@"Performing request:");
    PKLogDebug(@"%@", [operation.request pk_description]);
    
    [self enqueueHTTPRequestOperation:operation];
  } else {
    // Token expired, keep request until token is refreshed
    [self.pendingOperations addObject:operation];
    [self refreshOAuthToken];
  }
  
  return YES;
}

- (void)retryPendingOperations {
  PKLogDebug(@"Retrying %d requests...", [self.pendingOperations count]);
  
  for (PKHTTPRequestOperation *operation in self.pendingOperations) {
    // Update authorization header in case the token changed, e.g. due to a refresh
    [operation setValue:[self defaultValueForHeader:@"Authorization"] forHeader:@"Authorization"];
    
    PKLogDebug(@"Retrying request:");
    PKLogDebug(@"%@", [operation.request pk_description]);
    
    [self enqueueHTTPRequestOperation:operation];
  }
  
  [self.pendingOperations removeAllObjects];
}

- (void)cancelPendingOperations {
  PKLogDebug(@"Cancelling %d requests...", [self.pendingOperations count]);
  
  for (PKHTTPRequestOperation *operation in self.pendingOperations) {
    [operation cancel];
  }
  
  [self.pendingOperations removeAllObjects];
}

@end
