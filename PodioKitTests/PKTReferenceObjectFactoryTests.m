//
//  PKTReferenceObjectFactoryTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTConstants.h"
#import "PKTOrganization.h"
#import "PKTWorkspace.h"
#import "PKTProfile.h"
#import "PKTTask.h"
#import "PKTItem.h"
#import "PKTApp.h"
#import "PKTComment.h"
#import "PKTReferenceObjectFactory.h"

@interface PKTReferenceObjectFactoryTests : XCTestCase

@end

@implementation PKTReferenceObjectFactoryTests

- (void)testReferenceTypeNoneShouldReturnNil {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{} type:PKTReferenceTypeNone]).to.beNil();
}

- (void)testNoDataShouldReturnNil {
  expect([PKTReferenceObjectFactory referenceObjectFromData:nil type:PKTReferenceTypeSpace]).to.beNil();
}

- (void)testOrganizationObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"org_id" : @1234} type:PKTReferenceTypeOrg]).to.beInstanceOf([PKTOrganization class]);
}

- (void)testWorkspaceObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"space_id" : @1234} type:PKTReferenceTypeSpace]).to.beInstanceOf([PKTWorkspace class]);
}

- (void)testTaskObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"task_id" : @1234} type:PKTReferenceTypeTask]).to.beInstanceOf([PKTTask class]);
}

- (void)testProfileObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"profile_id" : @1234} type:PKTReferenceTypeProfile]).to.beInstanceOf([PKTProfile class]);
}

- (void)testItemObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"item_id" : @1234} type:PKTReferenceTypeItem]).to.beInstanceOf([PKTItem class]);
}

- (void)testAppObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"app_id" : @1234} type:PKTReferenceTypeApp]).to.beInstanceOf([PKTApp class]);
}

- (void)testCommentObject {
  expect([PKTReferenceObjectFactory referenceObjectFromData:@{@"comment_id" : @1234} type:PKTReferenceTypeComment]).to.beInstanceOf([PKTComment class]);
}

@end
