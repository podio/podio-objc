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

- (void)testMarkNotificationsAsViewedByReference {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationsAsViewedWithReferenceID:1234 type:PKTReferenceTypeItem];
  
  expect(request.path).to.equal(@"/notification/item/1234/viewed");
  expect(request.method).to.equal(PKTRequestMethodPOST);
}

- (void)testMarkNotificationsAsUnviewedByReference {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationsAsUnviewedWithReferenceID:1234 type:PKTReferenceTypeItem];
  
  expect(request.path).to.equal(@"/notification/item/1234/viewed");
  expect(request.method).to.equal(PKTRequestMethodDELETE);
}

- (void)testMarkNotificationAsViewed {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationAsViewedWithID:1234];
  
  expect(request.path).to.equal(@"/notification/1234/viewed");
  expect(request.method).to.equal(PKTRequestMethodPOST);
}

- (void)testMarkNotificationAsUnviewed {
  PKTRequest *request = [PKTNotificationsAPI requestToMarkNotificationAsUnviewedWithID:1234];
  
  expect(request.path).to.equal(@"/notification/1234/viewed");
  expect(request.method).to.equal(PKTRequestMethodDELETE);
}

- (void)testStarNotification {
  PKTRequest *request = [PKTNotificationsAPI requestToStarNotificationWithID:1234];
  
  expect(request.path).to.equal(@"/notification/1234/star");
  expect(request.method).to.equal(PKTRequestMethodPOST);
}

- (void)testUnstarNotification {
  PKTRequest *request = [PKTNotificationsAPI requestToUnstarNotificationWithID:1234];
  
  expect(request.path).to.equal(@"/notification/1234/star");
  expect(request.method).to.equal(PKTRequestMethodDELETE);
}

@end
