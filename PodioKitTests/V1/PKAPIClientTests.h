//
//  PKAPIClientTests.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/5/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAsyncTestCase.h"

@interface PKAPIClientTests : PKTAsyncTestCase

- (void)testAuthenticate;
- (void)testRefreshWhenTokenInvalid;
- (void)testDontRefreshWhenTokenValid;
- (void)testRefreshFailed;
- (void)testRefreshFailedDueToNetwork;
- (void)testUnauthorized;
- (void)testNotAuthenticated;
- (void)testRequestHeadersPresent;
- (void)testAuthorizationHeaderForEmailAndPasswordAuthenticationRequest;
- (void)testAuthorizationHeaderForSSOAuthenticationRequest;
- (void)testAuthorizationHeaderForRefreshRequest;

@end
