//
//  PKTClientTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 16/01/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTClient.h"
#import "PKTRequest.h"
#import "PKTResponse.h"

@interface PKTClientTests : XCTestCase

@end

@implementation PKTClientTests

- (void)testInit {
  NSString *key = @"some key";
  NSString *secret = @"secret";
  PKTClient *client = [[PKTClient alloc] initWithAPIKey:key secret:secret];

  expect(client.apiKey).to.equal(key);
  expect(client.apiSecret).to.equal(secret);
  expect([client.baseURL absoluteString]).to.equal(@"https://api.podio.com");
}

- (void)testPerformRequest {
//  PKTClient *client = [PKTClient initWithKey:@"some key" secret:@"secret"];
//  
//  PKTRequest *request = [PKTRequest GETRequestWithPath:@"/user/status"];
//  
//  [self waitForCompletion:^{
//    BOOL completed = NO;
//    [client performRequest:request completion:^(PKTResponse *result, NSError *error) {
//      completed = YES;
//      [self didFinish];
//    }];
//  }]
//  
//  expect(completed).to.beTrue;
}

@end
