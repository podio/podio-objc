//
//  POAPIClient.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-01.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAPIClient.h"
#import "ASIHTTPRequest.h"
#import "PKRequestOperation.h"
#import "Reachability.h"
#import "NSString+URL.h"
#import "NSDictionary+URL.h"

// Notifications
NSString * const POAPIClientWillBeginAuthentication = @"POAPIClientWillBeginAuthentication";
NSString * const POAPIClientDidFinishAuthentication = @"POAPIClientDidFinishAuthentication";

NSString * const POAPIClientWillBeginReauthentication = @"POAPIClientWillBeginReauthentication";
NSString * const POAPIClientDidFinishReauthentication = @"POAPIClientDidFinishReauthentication";

NSString * const POAPIClientDidAuthenticateUser = @"POAPIClientDidAuthenticateUser";
NSString * const POAPIClientAuthenticationFailed = @"POAPIClientAuthenticationFailed";
NSString * const POAPIClientReauthenticationFailed = @"POAPIClientReauthenticationFailed";

NSString * const POAPIClientWillRefreshAccessToken = @"POAPIClientWillRefreshAccessToken";
NSString * const POAPIClientDidRefreshAccessToken = @"POAPIClientDidRefreshAccessToken";

NSString * const POAPIClientTokenRefreshFailed = @"POAPIClientTokenRefreshFailed";
NSString * const POAPIClientNeedsReauthentication = @"POAPIClientNeedsReauthentication";

NSString * const POAPIClientRequestFinished = @"POAPIClientRequestFinished";
NSString * const POAPIClientRequestFailed = @"POAPIClientRequestFailed";

NSString * const PKAPIClientNoInternetConnection = @"PKAPIClientNoInternetConnection";

// Constants

static NSString * const kDefaultBaseURL = @"https://api.podio.com";
static NSString * const kDefaultFileUploadURL = @"https://upload.podio.com/upload.php";
static NSString * const kDefaultFileDownloadURL = @"https://upload.podio.com/download.php";
static NSString * const kOAuthRedirectURL = @"podio://oauth";

@interface PKAPIClient ()

@property (nonatomic, readonly) ASINetworkQueue *networkQueue;
@property (nonatomic, strong) PKOAuth2Client *oauthClient;
@property (nonatomic, strong) NSMutableArray *pendingRequests;

// Auth flow completion handlers
- (void)didAuthenticateWithToken:(PKOAuth2Token *)token;
- (void)authenticationFailedWithResponseData:(NSString *)responseData;
- (void)didRefreshToken:(PKOAuth2Token *)token;
- (void)tokenRefreshFailed;

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
                                                      tokenURL:[NSString stringWithFormat:@"%@/oauth/token", self.baseURLString] 
                                                   redirectURL:kOAuthRedirectURL];
  self.oauthClient.delegate = self;
}

#pragma mark - Authorization

- (void)authenticateWithEmail:(NSString *)email password:(NSString *)password {
  NSAssert(self.oauthClient != nil, @"API client not yet configured with OAuth2 client id and secret.");
  
  if (isAuthenticating_) {
    PKLogDebug(@"Already in the process of authenticating.");
    return;
  }
  
  if (![[Reachability reachabilityForInternetConnection] isReachable]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNoInternetConnection object:nil];
    return;
  }
  
  @synchronized(self) {
    [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientWillBeginAuthentication 
                                                        object:nil];
    isAuthenticating_ = YES;
    [self.oauthClient authenticateWithUsername:email password:password];
  }
}

- (void)refreshToken {
  if ([self isAuthenticated]) {
    [self refreshUsingRefreshToken:self.authToken.refreshToken];
  } else {
    [self tokenRefreshFailed];
  }
}

- (void)refreshUsingRefreshToken:(NSString *)refreshToken {
  if (isRefreshingToken_) {
    PKLogDebug(@"Already in the process of refreshing token.");
    return;
  }
  
  if (![[Reachability reachabilityForInternetConnection] isReachable]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNoInternetConnection object:nil];
    return;
  }
  
  @synchronized(self) {
    [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientWillRefreshAccessToken 
                                                        object:nil];
    
    isRefreshingToken_ = YES;
    [self.oauthClient refreshUsingRefreshToken:refreshToken];
  }
}

- (void)needsReauthentication {
  self.authToken = nil;
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientNeedsReauthentication object:nil];
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
  
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientDidFinishAuthentication object:nil];
}

- (void)authenticationFailedWithResponseData:(NSString *)responseData {
  isAuthenticating_ = NO;
  self.authToken = nil; // Reset token
  
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientDidFinishAuthentication object:nil];
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientAuthenticationFailed object:responseData];
}

- (void)didRefreshToken:(PKOAuth2Token *)token {
  isRefreshingToken_ = NO;
  self.authToken = token; // Keep token
  
  [self resendPendingRequests];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientDidRefreshAccessToken object:self.authToken];
}

- (void)tokenRefreshFailed {
  isRefreshingToken_ = NO;
  
  self.authToken = nil;
  
  [self cancelPendingRequests];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientTokenRefreshFailed object:nil];
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientNeedsReauthentication object:nil];
}

#pragma mark - Requests

- (ASINetworkQueue *)networkQueue {
  if (networkQueue_ == nil) {
    networkQueue_ = [[ASINetworkQueue alloc] init];
    [networkQueue_ setMaxConcurrentOperationCount:NSOperationQueueDefaultMaxConcurrentOperationCount];
    [networkQueue_ setShouldCancelAllRequestsOnFailure:NO];
 		[networkQueue_ go];
  }
  
  return networkQueue_;
}

- (BOOL)addRequestOperation:(PKRequestOperation *)operation {
  if (![[Reachability reachabilityForInternetConnection] isReachable]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNoInternetConnection object:nil];
    operation.requestCompletionBlock([NSError pk_noConnectionError], nil);
    return NO;
  }
  
  operation.delegate = self;
  
  [operation addRequestHeader:@"User-Agent" value:self.userAgent];
  [operation addRequestHeader:@"Authorization" value:[self authorizationHeader]];

  // Enqueue
  if ([self isAuthenticated] && ![self.authToken hasExpired]) {
    [self startRequest:operation];
  } else {
    // Token expired, keep request until token is refreshed
    [self.pendingRequests addObject:operation];
    [self refreshToken];
  }
  
  return YES;
}

- (BOOL)addFileOperation:(PKFileOperation *)operation {
  if (![[Reachability reachabilityForInternetConnection] isReachable]) {
    [[NSNotificationCenter defaultCenter] postNotificationName:PKAPIClientNoInternetConnection object:nil];
    operation.requestCompletionBlock([NSError pk_noConnectionError], nil);
    return NO;
  }
  
  operation.delegate = self;
  
  [operation addRequestHeader:@"User-Agent" value:self.userAgent];
  [operation addRequestHeader:@"AccessToken" value:self.authToken.accessToken];
  [operation addRequestHeader:@"RefreshToken" value:self.authToken.refreshToken];
  
  // Enqueue
  if ([self isAuthenticated] && ![self.authToken hasExpired]) {
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
#endif
  
  [self.networkQueue addOperation:request];
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
  if ([request responseStatusCode] == 401) {
    [self needsReauthentication];
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientRequestFinished object:request];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
  if ([request responseStatusCode] == 401) {
    [self needsReauthentication];
  }
  
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientRequestFailed object:request];
}

#pragma mark - PKOAuth2ClientDelegate

- (void)oauthClient:(PKOAuth2Client *)oauthClient didReceiveToken:(PKOAuth2Token *)token {
  [self didAuthenticateWithToken:token];
  [[NSNotificationCenter defaultCenter] postNotificationName:POAPIClientDidAuthenticateUser object:self.authToken];
}

- (void)oauthClientAuthenticationDidFail:(PKOAuth2Client *)oauthClient responseData:(id)responseData {
  [self authenticationFailedWithResponseData:responseData];
}

- (void)oauthClient:(PKOAuth2Client *)oauthClient didRefreshToken:(PKOAuth2Token *)token {
  [self didRefreshToken:token];
}

- (void)oauthClientTokenRefreshDidFail:(PKOAuth2Client *)oauthClient {
  [self tokenRefreshFailed];
}

@end
