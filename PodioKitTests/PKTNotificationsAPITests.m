//
//  PKTNotificationsAPITests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTNotificationsAPI.h"

@interface PKTNotificationsAPITests : XCTestCase

@end

@implementation PKTNotificationsAPITests

- (void)testGetNotificationsRequest {
  PKTRequest *request = [PKTNotificationsAPI requestForNotificationsWithOffset:40 limit:20];
  
  expect(request.path).to.equal(@"/notification/");
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
}

- (void)testGetNotificationsRequestWithParameters {
  PKTNotificationsRequestParameters *params = [PKTNotificationsRequestParameters new];
  params.viewed = PKTNotificationViewedStateViewed;
  params.starred = PKTNotificationStarredStateUnstarred;
  
  PKTRequest *request = [PKTNotificationsAPI requestForNotificationsWithParameters:params offset:40 limit:20];
  
  expect(request.path).to.equal(@"/notification/");
  expect(request.method).to.equal(PKTRequestMethodGET);
  expect(request.parameters[@"offset"]).to.equal(@40);
  expect(request.parameters[@"limit"]).to.equal(@20);
  expect(request.parameters[@"viewed"]).to.equal(@YES);
  expect(request.parameters[@"starred"]).to.equal(@NO);
}

@end
