//
//  PKTAuthenticationAPITests.m
//  PodioKit
//
//  Created by Romain Briche on 28/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTAuthenticationAPI.h"

@interface PKTAuthenticationAPITests : XCTestCase

@end

@implementation PKTAuthenticationAPITests

- (void)testRequestForAuthenticationWithEmailPassword {
  NSString *email, *password;
  email = @"some@email.com";
  password = @"aSecurePassword";

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithEmail:email password:password];

  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/oauth/token");
  expect(request.parameters[@"username"]).to.equal(email);
  expect(request.parameters[@"password"]).to.equal(password);
  expect(request.parameters[@"grant_type"]).to.equal(@"password");
}

- (void)testRequestForAuthenticationWithAppIDAndToken {
  NSUInteger appID = 1234;
  NSString *appToken = @"aAppToken";

  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithAppID:appID token:appToken];

  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/oauth/token");
  expect(request.parameters[@"app_id"]).to.equal(appID);
  expect(request.parameters[@"app_token"]).to.equal(appToken);
  expect(request.parameters[@"grant_type"]).to.equal(@"app");
}

- (void)testRequestForAuthenticationWithTransferToken {
  NSString *transferToken = @"4534fgsdfsd52";
  
  PKTRequest *request = [PKTAuthenticationAPI requestForAuthenticationWithTransferToken:transferToken];
  
  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/oauth/token");
  expect(request.parameters[@"transfer_token"]).to.equal(transferToken);
  expect(request.parameters[@"grant_type"]).to.equal(@"transfer_token");
}

- (void)testRequestForRefreshToken {
  NSString *refreshToken = @"aRefreshToken";

  PKTRequest *request = [PKTAuthenticationAPI requestToRefreshToken:refreshToken];

  expect(request.method).to.equal(PKTRequestMethodPOST);
  expect(request.path).to.equal(@"/oauth/token");
  expect(request.parameters[@"refresh_token"]).to.equal(refreshToken);
  expect(request.parameters[@"grant_type"]).to.equal(@"refresh_token");
}

@end
