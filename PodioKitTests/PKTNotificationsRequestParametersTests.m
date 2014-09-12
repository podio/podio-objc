//
//  PKTNotificationsRequestParametersTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTNotificationsRequestParameters.h"

static NSTimeInterval const kSecondsPerDay = 24 * 60 * 60;

@interface PKTNotificationsRequestParametersTests : XCTestCase

@end

@implementation PKTNotificationsRequestParametersTests

- (void)testNotificationsParameters {
  PKTNotificationsRequestParameters *params = [PKTNotificationsRequestParameters new];
  
  params.userID = 111;
  params.contextType = PKTReferenceTypeItem;
  params.direction = PKTNotificationDirectionOutgoing;
  params.viewed = PKTNotificationViewedStateViewed;         
  params.starred = PKTNotificationStarredStateStarred;
  params.createdFromDate = [NSDate dateWithTimeIntervalSince1970:kSecondsPerDay];
  params.createdToDate = [NSDate dateWithTimeIntervalSince1970:2 * kSecondsPerDay];
  params.viewedFromDate = [NSDate dateWithTimeIntervalSince1970:3 * kSecondsPerDay];
  
  NSDictionary *queryParameters = [params queryParameters];
  expect(queryParameters[@"context_type"]).to.equal(@"item");
  expect(queryParameters[@"user_id"]).to.equal(@111);
  expect(queryParameters[@"starred"]).to.equal(@YES);
  expect(queryParameters[@"viewed"]).to.equal(@YES);
  expect(queryParameters[@"direction"]).to.equal(@"outgoing");
  expect(queryParameters[@"created_from"]).to.equal(@"1970-01-02");
  expect(queryParameters[@"created_to"]).to.equal(@"1970-01-03");
  expect(queryParameters[@"viewed_from"]).to.equal(@"1970-01-04");
}

@end
