//
//  PKAPIClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAPIClient.h"
#import "ASIHTTPRequest.h"
#import "PKRequestOperation.h"
#import "NSString+URL.h"
#import "NSDictionary+URL.h"

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

NSString * const PKAPIClientRequestFinished = @"PKAPIClientRequestFinished";
NSString * const PKAPIClientRequestFailed = @"PKAPIClientRequestFailed";

NSString * const PKAPIClientNoInternetConnection = @"PKAPIClientNoInternetConnection";

// Notification user info keys
NSString * const PKAPIClientRequestKey = @"Request";
NSString * const PKAPIClientTokenKey = @"Token";
NSString * const PKAPIClientErrorKey = @"Error";

// Constants

static NSString * const kDefaultBaseURL = @"https://api.podio.com";
static NSString * const kDefaultFileUploadURL = @"https://upload.podio.com/upload.php";
static NSString * const kDefaultFileDownloadURL = @"https://upload.podio.com/download.php";
static NSString * const kOAuthRedirectURL = @"podio://oauth";

@interface PKAPIClient ()

@property (nonatomic, readonly) ASINetworkQueue *networkQueue;
@property (nonatomic, readonly) ASINetworkQueue *serialNetworkQueue;
@property (nonatomic, strong) PKOAuth2Client *oauthClient;
@property (nonatomic, strong) NSMutableArray *pendingRequests;

// Auth flow completion handlers
- (void)didAuthenticateWithToken:(PKOAuth2Token *)token;
- (void)authenticationFailedWithResponseData:(id)responseData;
- (void)didRefreshToken:(PKOAuth2Token *)token;
- (void)tokenRefreshFailedWithError:(NSError *)error;

// Enqueueing requests
- (void)startRequest:(ASIHTTPRequest *)request;
- (void)resendPendingRequests;
- (void)cancelPendingRequests;

- (NSString *)authorizationHeader;

@end

@implementation PKAPIClient

@synthesize baseURLString = baseURLString_;
@synthesize fileUploadURLString = fileUploadURLString_;
@synthesize fileDownloadURLString = fileDownloadURLString_;
@synthesize userAgent = userAgent_;
@synthesize authToken = authToken_;
@synthesize oauthClient = oauthClient_;
@synthesize pendingRequests = pendingRequests_;

#pragma mark - Singleton

+ (PKAPIClient *)sharedClient {
  static PKAPIClient * sharedInstance = nil;
  static dispatch_once_t pred;
  
  dispatch_once(&pred, ^{
    sharedInstance = [[self alloc] init];
  });
  
  return sharedInstance;
}

- (id)init {
  @synchronized(self) {
    self = [super init];
    
    // Shared request queue
    networkQueue_ = nil;
    serialNetworkQueue_ = nil;
    
    // OAuth
    self.oauthClient = nil;
    
    authToken_ = nil;
    
    isRefreshingToken_ = NO;
    isAuthenticating_ = NO;
    
    fileUploadURLString_ = [kDefaultFileUploadURL copy];
    fileDownloadURLString_ = [kDefaultFileDownloadURL copy];
    
    pendingRequests_ = [[NSMutableArray alloc] init];
    
    return self;
  }
}

- (void)setBaseURLString:(NSString *)baseURLString {
  NSURL *baseURL = [NSURL URLWithString:baseURLString];
  if (baseURLString == nil) {
    PKLogError(@"Invalid base URL: %@", baseURLString);
    return;
  }
  
  if (baseURLString_ != nil) {
    baseURLString_ = nil;
  }
  
  baseURLString_ = [[NSString stringWithFormat:@"https://%@", [baseURL host]] copy];
}

- (void)configureWithClientId:(NSString *)clientId secret:(NSString *)secret {
  [self configureWithClientId:clientId secret:secret baseURLString:kDefaultBaseURL];
}

- (void)configureWithClientId:(NSString *)clientId secret:(NSString *)secret baseURLString:(NSString *)baseURLString {
  self.baseURLString = baseURLString;
  
  self.oauthClient = [[PKOAuth2Client alloc] initWithClientID:clientId 
                                                  clientSecret:secret 
                                                      tokenURL:[NSString stringWithFormat:@"%@/oauth/token", self.baseURLString]];
  self.oauthClient.delegate = self;
}

#pragma mark - Authorization

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password {
  PKAssert(self.oauthClient != nil, @"API client not yet configured with OAuth2 client id and secret.");
  
  if (isAuthenticating_) {
    PKLogDebug(@"Already in the process of authenticating.");
    return;
  }
  
  @synchronized(self) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillBeginAuthentication object:self];
    
    isAuthenticating_ = YES;
    [self.oauthClient authenticateWithUsername:email password:password];
  }
}

- (void)authenticateWithGrantType:(NSString *)grantType body:(NSDictionary *)body {
  PKAssert(self.oauthClient != nil, @"API client not yet configured with OAuth2 client id and secret.");
  
  if (isAuthenticating_) {
    PKLogDebug(@"Already in the process of authenticating.");
    return;
  }
  
  @synchronized(self) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillBeginAuthentication object:self];
    
    isAuthenticating_ = YES;
    [self.oauthClient authenticateWithGrantType:grantType body:body];
  }
}

- (void)refreshToken {
  if ([self isAuthenticated]) {
    [self refreshUsingRefreshToken:self.authToken.refreshToken];
  } else {
    [self tokenRefreshFailedWithError:[NSError pk_notAuthenticatedError]];
  }
}

- (void)refreshUsingRefreshToken:(NSString *)refreshToken {
  if (isRefreshingToken_) {
    PKLogDebug(@"Already in the process of refreshing token.");
    return;
  }
  
  @synchronized(self) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientWillRefreshAccessToken object:self];
    
    isRefreshingToken_ = YES;
    [self.oauthClient refreshUsingRefreshToken:refreshToken];
  }
}

- (void)handleUnauthorized {
  self.authToken = nil;
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNeedsReauthentication object:self];
}

- (BOOL)isAuthenticated {
  return self.authToken != nil;
}

- (NSString *)URLStringForPath:(NSString *)path parameters:(NSDictionary *)parameters {
  NSMutableString *urlString = urlString = [NSMutableString stringWithFormat:@"%@%@", self.baseURLString, path];
  
  if (parameters != nil && [parameters count] > 0) {
    [urlString appendFormat:@"?%@", [parameters pk_escapedURLStringFromComponents]];
  }
  
  return urlString;
}

- (void)didAuthenticateWithToken:(PKOAuth2Token *)token {
  isAuthenticating_ = NO;
  self.authToken = token; // Keep token
  
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidFinishAuthentication object:self];
}

- (void)authenticationFailedWithResponseData:(id)responseData {
  isAuthenticating_ = NO;
  self.authToken = nil; // Reset token
  
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidFinishAuthentication object:self];
  
  NSError *error = [NSError pk_serverErrorWithStatusCode:0 parsedData:responseData];
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientAuthenticationFailed object:self userInfo:@{PKAPIClientErrorKey: error}];
}

- (void)didRefreshToken:(PKOAuth2Token *)token {
  isRefreshingToken_ = NO;
  self.authToken = token; // Keep token
  
  [self resendPendingRequests];
  
  NSDictionary *userInfo = @{PKAPIClientTokenKey: token};
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidRefreshAccessToken object:self userInfo:userInfo];
}

- (void)tokenRefreshFailedWithError:(NSError *)error {
  isRefreshingToken_ = NO;
  
  [self cancelPendingRequests];
  
  if (![error.domain isEqualToString:NetworkRequestErrorDomain]) {
    // Server side error, re-authenticate
    self.authToken = nil;
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNeedsReauthentication object:self];
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientTokenRefreshFailed object:self];
}

#pragma mark - Requests

- (ASINetworkQueue *)networkQueue {
  if (networkQueue_ == nil) {
    networkQueue_ = [[ASINetworkQueue alloc] init];
    networkQueue_.maxConcurrentOperationCount = NSOperationQueueDefaultMaxConcurrentOperationCount;
    networkQueue_.shouldCancelAllRequestsOnFailure = NO;
 		[networkQueue_ go];
  }
  
  return networkQueue_;
}

- (ASINetworkQueue *)serialNetworkQueue {
  if (serialNetworkQueue_ == nil) {
    serialNetworkQueue_ = [[ASINetworkQueue alloc] init];
    networkQueue_.maxConcurrentOperationCount = 1;
    networkQueue_.shouldCancelAllRequestsOnFailure = NO;
 		[serialNetworkQueue_ go];
  }
  
  return serialNetworkQueue_;
}

- (BOOL)addRequestOperation:(PKRequestOperation *)operation {
  if (operation.requiresAuthenticated && ![self isAuthenticated]) {
    operation.requestCompletionBlock([NSError pk_notAuthenticatedError], nil);
    return NO;
  }
  
  operation.delegate = self;
  
  [operation addRequestHeader:@"User-Agent" value:self.userAgent];
  
  NSArray *languages = [NSLocale preferredLanguages];
  if ([languages count] > 0) {
    [operation addRequestHeader:@"Accept-Language" value:languages[0]];
  }
  
  if (operation.requiresAuthenticated) {
    // Use OAuth
    [operation addRequestHeader:@"Authorization" value:[self authorizationHeader]];
  } else {
    // Use trusted authentication with HTTP Basic Auth
    operation.username = self.oauthClient.clientID;
    operation.password = self.oauthClient.clientSecret;
    operation.authenticationScheme = (NSString *)kCFHTTPAuthenticationSchemeBasic;
  }
  
  if (![self.authToken hasExpired]) {
    [self startRequest:operation];
  } else {
    // Token expired, keep request until token is refreshed
    [self.pendingRequests addObject:operation];
    [self refreshToken];
  }
  
  return YES;
}

- (BOOL)addFileOperation:(PKFileOperation *)operation {  
  if (![self isAuthenticated]) {
    operation.requestCompletionBlock([NSError pk_notAuthenticatedError], nil);
    return NO;
  }
  
  operation.delegate = self;
  
  [operation addRequestHeader:@"User-Agent" value:self.userAgent];
  [operation addRequestHeader:@"AccessToken" value:self.authToken.accessToken];
  [operation addRequestHeader:@"RefreshToken" value:self.authToken.refreshToken];
  
  // Enqueue
  if (![self.authToken hasExpired]) {
    [self startRequest:operation];
  } else {
    // Token expired, keep request until token is refreshed
    [self.pendingRequests addObject:operation];
    [self refreshToken];
  }
  
  return YES;
}

- (void)startRequest:(ASIHTTPRequest *)request {
#ifdef DEBUG
  PKLogDebug(@"Request URL: %@", [request.url absoluteString]);
  PKLogDebug(@"Headers:");
  
  if ([[request requestHeaders] count] > 0) {
    [[request requestHeaders] enumerateKeysAndObjectsUsingBlock:^(id name, id value, BOOL *stop) {
      PKLogDebug(@"  %@: %@", name, value); 
    }];
  }
  
  if ([request.postBody length] > 0) {
    PKLogDebug(@"Body: %@", [[NSString alloc] initWithData:request.postBody encoding:NSUTF8StringEncoding]);
  }
#endif
  
  if ([request isKindOfClass:[PKRequestOperation class]] && ![(PKRequestOperation *)request allowsConcurrent]) {
    [self.serialNetworkQueue addOperation:request];
  } else {
    [self.networkQueue addOperation:request];
  }
}

- (void)resendPendingRequests {
  [self.pendingRequests enumerateObjectsUsingBlock:^(id request, NSUInteger idx, BOOL *stop) {
    // Update authorization header with new token
    
    if ([request isKindOfClass:[PKFileOperation class]]) {
      // File operation
      [request addRequestHeader:@"AccessToken" value:self.authToken.accessToken];
      [request addRequestHeader:@"RefreshToken" value:self.authToken.refreshToken];
    } else {
      // Regular
      [request addRequestHeader:@"Authorization" value:[self authorizationHeader]];
    }
    
    [self startRequest:request];
  }];
  
  [self.pendingRequests removeAllObjects];
}

- (void)cancelPendingRequests {
  [self.pendingRequests enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    PKRequestOperation *operation = obj;
    operation.requestCompletionBlock([NSError pk_requestCancelledError], nil);
  }];
  
  [self.pendingRequests removeAllObjects];
}

- (NSString *)authorizationHeader {
  return [NSString stringWithFormat:@"OAuth2 %@", [self.authToken.accessToken pk_escapedURLString]];
}

#pragma mark - ASIHTTPRequestDelegate

- (void)requestFinished:(ASIHTTPRequest *)request {
  if (request.responseStatusCode == 401) {
    [self handleUnauthorized];
  }
  
  NSDictionary *userInfo = @{PKAPIClientRequestKey: request};
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientRequestFinished object:self userInfo:userInfo];
}

- (void)requestFailed:(ASIHTTPRequest *)request {  
  if (request.responseStatusCode == 401) {
    [self handleUnauthorized];
  }
  
  NSDictionary *userInfo = @{PKAPIClientRequestKey: request};
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientRequestFailed object:self userInfo:userInfo];
}

#pragma mark - PKOAuth2ClientDelegate

- (void)oauthClient:(PKOAuth2Client *)oauthClient didReceiveToken:(PKOAuth2Token *)token {
  [self didAuthenticateWithToken:token];
  
  NSDictionary *userInfo = @{PKAPIClientTokenKey: token};
  [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientDidAuthenticateUser object:self userInfo:userInfo];
}

- (void)oauthClientAuthenticationDidFail:(PKOAuth2Client *)oauthClient responseData:(id)responseData {
  [self authenticationFailedWithResponseData:responseData];
}

- (void)oauthClient:(PKOAuth2Client *)oauthClient didRefreshToken:(PKOAuth2Token *)token {
  [self didRefreshToken:token];
}

- (void)oauthClientTokenRefreshDidFail:(PKOAuth2Client *)oauthClient error:(NSError *)error {
  [self tokenRefreshFailedWithError:error];
}

@end
