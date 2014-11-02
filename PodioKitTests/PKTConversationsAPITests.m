//
//  PKTConversationsAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTConversationsAPI.h"

@interface PKTConversationsAPITests : XCTestCase

@end

@implementation PKTConversationsAPITests

- (void)testGetConversationsRequest {
  PKTRequest *request = [PKTConversationsAPI requestForConversationsWithOffset:40 limit:20];
  
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/conversation/");
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
}

- (void)testGetConversationEventsRequest {
  PKTRequest *request = [PKTConversationsAPI requestForEventsInConversationWithID:1234 offset:40 limit:20];
  
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.path).to.equal(@"/conversation/1234/event/");
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
}

@end
