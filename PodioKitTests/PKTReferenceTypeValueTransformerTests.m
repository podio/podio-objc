//
//  PKTReferenceTypeValueTransformerTests.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTConstants.h"
#import "PKTReferenceTypeValueTransformer.h"

@interface PKTReferenceTypeValueTransformerTests : XCTestCase

@end

@implementation PKTReferenceTypeValueTransformerTests

- (void)testReferenceTypesValueTransformation {
  PKTReferenceTypeValueTransformer *transformer = [PKTReferenceTypeValueTransformer new];
  expect([transformer transformedValue:@"app"]).to.equal(PKTReferenceTypeApp);
  expect([transformer transformedValue:@"app_revision"]).to.equal(PKTReferenceTypeAppRevision);
  expect([transformer transformedValue:@"app_field"]).to.equal(PKTReferenceTypeAppField);
  expect([transformer transformedValue:@"item"]).to.equal(PKTReferenceTypeItem);
  expect([transformer transformedValue:@"bulletin"]).to.equal(PKTReferenceTypeBulletin);
  expect([transformer transformedValue:@"comment"]).to.equal(PKTReferenceTypeComment);
  expect([transformer transformedValue:@"status"]).to.equal(PKTReferenceTypeStatus);
  expect([transformer transformedValue:@"space_member"]).to.equal(PKTReferenceTypeSpaceMember);
  expect([transformer transformedValue:@"alert"]).to.equal(PKTReferenceTypeAlert);
  expect([transformer transformedValue:@"item_revision"]).to.equal(PKTReferenceTypeItemRevision);
  expect([transformer transformedValue:@"rating"]).to.equal(PKTReferenceTypeRating);
  expect([transformer transformedValue:@"task"]).to.equal(PKTReferenceTypeTask);
  expect([transformer transformedValue:@"task_action"]).to.equal(PKTReferenceTypeTaskAction);
  expect([transformer transformedValue:@"space"]).to.equal(PKTReferenceTypeSpace);
  expect([transformer transformedValue:@"org"]).to.equal(PKTReferenceTypeOrg);
  expect([transformer transformedValue:@"conversation"]).to.equal(PKTReferenceTypeConversation);
  expect([transformer transformedValue:@"message"]).to.equal(PKTReferenceTypeMessage);
  expect([transformer transformedValue:@"notification"]).to.equal(PKTReferenceTypeNotification);
  expect([transformer transformedValue:@"file"]).to.equal(PKTReferenceTypeFile);
  expect([transformer transformedValue:@"file_service"]).to.equal(PKTReferenceTypeFileService);
  expect([transformer transformedValue:@"profile"]).to.equal(PKTReferenceTypeProfile);
  expect([transformer transformedValue:@"user"]).to.equal(PKTReferenceTypeUser);
  expect([transformer transformedValue:@"widget"]).to.equal(PKTReferenceTypeWidget);
  expect([transformer transformedValue:@"share"]).to.equal(PKTReferenceTypeShare);
  expect([transformer transformedValue:@"form"]).to.equal(PKTReferenceTypeForm);
  expect([transformer transformedValue:@"auth_client"]).to.equal(PKTReferenceTypeAuthClient);
  expect([transformer transformedValue:@"connection"]).to.equal(PKTReferenceTypeConnection);
  expect([transformer transformedValue:@"integration"]).to.equal(PKTReferenceTypeIntegration);
  expect([transformer transformedValue:@"share_install"]).to.equal(PKTReferenceTypeShareInstall);
  expect([transformer transformedValue:@"icon"]).to.equal(PKTReferenceTypeIcon);
  expect([transformer transformedValue:@"org_member"]).to.equal(PKTReferenceTypeOrgMember);
  expect([transformer transformedValue:@"news"]).to.equal(PKTReferenceTypeNews);
  expect([transformer transformedValue:@"hook"]).to.equal(PKTReferenceTypeHook);
  expect([transformer transformedValue:@"tag"]).to.equal(PKTReferenceTypeTag);
  expect([transformer transformedValue:@"embed"]).to.equal(PKTReferenceTypeEmbed);
  expect([transformer transformedValue:@"question"]).to.equal(PKTReferenceTypeQuestion);
  expect([transformer transformedValue:@"question_answer"]).to.equal(PKTReferenceTypeQuestionAnswer);
  expect([transformer transformedValue:@"action"]).to.equal(PKTReferenceTypeAction);
  expect([transformer transformedValue:@"contract"]).to.equal(PKTReferenceTypeContract);
  expect([transformer transformedValue:@"meeting"]).to.equal(PKTReferenceTypeMeeting);
  expect([transformer transformedValue:@"batch"]).to.equal(PKTReferenceTypeBatch);
  expect([transformer transformedValue:@"system"]).to.equal(PKTReferenceTypeSystem);
  expect([transformer transformedValue:@"space_member_request"]).to.equal(PKTReferenceTypeSpaceMemberRequest);
  expect([transformer transformedValue:@"live"]).to.equal(PKTReferenceTypeLive);
  expect([transformer transformedValue:@"item_participation"]).to.equal(PKTReferenceTypeItemParticipation);
}

@end
