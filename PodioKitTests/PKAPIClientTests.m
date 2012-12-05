//
//  PKAPIClientTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/5/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAPIClientTests.h"
#import "OHHTTPStubs.h"
#import "PKAPIClient.h"
#import "PKRequestManager.h"
#import "PKOAuth2Token.h"

static NSString * const kAPIKey = @"test-api-key";
static NSString * const kAPISecret = @"test-api-secret";

@interface PKAPIClientTests ()

@property (strong) PKAPIClient *apiClient;

@end

@implementation PKAPIClientTests

- (void)setUp {
  self.apiClient = [[PKAPIClient alloc] initWithAPIKey:kAPIKey apiSecret:kAPISecret];
  [PKRequestManager sharedManager].apiClient = self.apiClient;
}

- (void)tearDown {
  self.apiClient = nil;
  [OHHTTPStubs removeAllRequestHandlers];
}

- (void)testAuthenticate {
  [self stubResponseForPath:@"/oauth/token" withJSONObject:[self validTokenResponse] statusCode:200];
  
  [self.apiClient authenticateWithEmail:@"me@pdio.com" password:@"Myp4$$w0rD" completion:^(NSError *error, PKRequestResult *result) {
    [self didFinish];
  }];
  
  [self waitForCompletion];
  
  STAssertNotNil(self.apiClient.oauthToken, @"Token should not be nil");
}

- (void)testRefreshWhenTokenInvalid {
  // Token will expire very soon
  NSDictionary *soonExpiredDict = [self soonExpiredTokenResponse];
  NSDictionary *validDict = [self validTokenResponse];
  self.apiClient.oauthToken = [PKOAuth2Token tokenFromDictionary:soonExpiredDict];
  
  [self stubResponseForPath:@"/oauth/token" withJSONObject:validDict statusCode:200];
  [self stubResponseForPath:@"/text" withJSONObject:@{@"text": @"some text"} statusCode:200];
  
  [[PKRequest getRequestWithURI:@"/text"] startWithCompletionBlock:^(NSError *error, PKRequestResult *result) {
    STAssertNil(error, @"Error should be nil, got %@", [error localizedDescription]);
    [self didFinish];
  }];
  
  [self waitForCompletion];
  
  STAssertTrue([self.apiClient.oauthToken.accessToken isEqualToString:validDict[@"access_token"]], @"Wrong token, should be %@", validDict[@"access_token"]);
}

- (void)testDontRefreshWhenTokenValid {
  // Token will expire very soon
  NSDictionary *validDict = [self validTokenResponse];
  self.apiClient.oauthToken = [PKOAuth2Token tokenFromDictionary:validDict];
  
  [self stubResponseForPath:@"/text" withJSONObject:@{@"text": @"some text"} statusCode:200];
  
  [[PKRequest getRequestWithURI:@"/text"] startWithCompletionBlock:^(NSError *error, PKRequestResult *result) {
    STAssertNil(error, @"Error should be nil, got %@", [error localizedDescription]);
    [self didFinish];
  }];
  
  [self waitForCompletion];
  
  STAssertTrue([self.apiClient.oauthToken.accessToken isEqualToString:validDict[@"access_token"]], @"Wrong token, should be %@", validDict[@"access_token"]);
}

- (void)testRequestHeadersPresent {
  self.apiClient.oauthToken = [PKOAuth2Token tokenFromDictionary:[self validTokenResponse]];
  
  NSURLRequest *request = [self.apiClient requestWithMethod:PKRequestMethodGET path:@"/some/path" parameters:nil body:nil];
  PKHTTPRequestOperation *operation = [self.apiClient operationWithRequest:request completion:nil];
  
  STAssertNotNil([operation.request.allHTTPHeaderFields valueForKey:@"X-Podio-Request-Id"], @"Missing header 'X-Podio-Request-Id'");
  STAssertNotNil([operation.request.allHTTPHeaderFields valueForKey:@"Authorization"], @"Missing header 'Authorization'");
  STAssertNotNil([operation.request.allHTTPHeaderFields valueForKey:@"Accept-Language"], @"Missing header 'Accept-Language'");
}

#pragma mark - Helpers

- (void)stubResponseForPath:(NSString *)path withJSONObject:(id)object statusCode:(NSUInteger)statusCode {
  [OHHTTPStubs addRequestHandler:^OHHTTPStubsResponse *(NSURLRequest *request, BOOL onlyCheck) {
    if ([request.URL.path isEqualToString:path]) {
      return [OHHTTPStubsResponse responseWithData:[NSJSONSerialization dataWithJSONObject:object options:0 error:nil]
                                        statusCode:statusCode
                                      responseTime:0
                                           headers:nil];
    }
    
    return nil;
  }];
}

#pragma mark - Fixtures

- (id)validTokenResponse {
  return @{
    @"access_token": @"6eebb61891d7d716b8dc3c45020f54aa",
    @"expires_in": @(28799), // Regular expiration
    @"ref": @{
      @"id": @(12345),
      @"type": @"user"
    },
    @"refresh_token": @"dd7aa62f25d8d8b480293a8985215aa3",
    @"token_type": @"bearer"
  };
}

- (id)soonExpiredTokenResponse {
  return @{
    @"access_token": @"6eebb618917646d8d8dc3c45020f54bb",
    @"expires_in": @(60), // Expires in a minute
    @"ref": @{
      @"id": @(12345),
      @"type": @"user"
    },
    @"refresh_token": @"dd7aa62fd8d84db480293a89sdf8ds8f",
    @"token_type": @"bearer"
  };
}

@end
