//
//  PKTNotificationObjectFactoryTests.m
//  PodioKit
//
//  Created by Romain Briche on 23/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTNotificationObjectFactory.h"
#import "PKTConstants.h"
#import "PKTComment.h"
#import "PKTAppFieldConfig.h"
#import "PKTItemRevision.h"

@interface PKTNotificationObjectFactoryTests : XCTestCase

@end

@implementation PKTNotificationObjectFactoryTests

- (void)testNotificationTypeUnknownShouldReturnNil {
  expect([PKTNotificationObjectFactory notificationObjectFromData:@{} type:PKTNotificationTypeUnknown]).to.beNil();
}

- (void)testNoDataShouldReturnNil {
  expect([PKTNotificationObjectFactory notificationObjectFromData:nil type:PKTNotificationTypeComment]).to.beNil();
}

- (void)testCommentObject {
  expect([PKTNotificationObjectFactory notificationObjectFromData:@{@"comment_id" : @1234} type:PKTNotificationTypeComment]).to.beInstanceOf([PKTComment class]);
}

- (void)testMemberReferenceAddObject {
  expect([PKTNotificationObjectFactory notificationObjectFromData:@{@"label" : @"test"} type:PKTNotificationTypeMemberReferenceAdd]).to.beInstanceOf([PKTAppFieldConfig class]);
}

- (void)testMemberReferenceRemoveObject {
  expect([PKTNotificationObjectFactory notificationObjectFromData:@{@"label" : @"test"} type:PKTNotificationTypeMemberReferenceRemove]).to.beInstanceOf([PKTAppFieldConfig class]);
}

- (void)testUpdateItemObject {
  expect([PKTNotificationObjectFactory notificationObjectFromData:@{@"item_revision_id" : @1234} type:PKTNotificationTypeUpdate]).to.beInstanceOf([PKTItemRevision class]);
}

@end
