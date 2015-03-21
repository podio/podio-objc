//
//  PKTNotificationTypeValueTransformerTests.m
//  PodioKit
//
//  Created by Romain Briche on 21/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "PKTNotificationTypeValueTransformer.h"
#import "PKTConstants.h"

@interface PKTNotificationTypeValueTransformerTests : XCTestCase

@end

@implementation PKTNotificationTypeValueTransformerTests

- (void)testNotificationTypesValueTransformation {
  PKTNotificationTypeValueTransformer *transformer = [PKTNotificationTypeValueTransformer new];
  expect([transformer transformedValue:@"alert"]).to.equal(PKTNotificationTypeAlert);
  expect([transformer transformedValue:@"team_alert"]).to.equal(PKTNotificationTypeTeamAlert);
  expect([transformer transformedValue:@"creation"]).to.equal(PKTNotificationTypeCreation);
  expect([transformer transformedValue:@"update"]).to.equal(PKTNotificationTypeUpdate);
  expect([transformer transformedValue:@"delete"]).to.equal(PKTNotificationTypeDelete);
  expect([transformer transformedValue:@"comment"]).to.equal(PKTNotificationTypeComment);
  expect([transformer transformedValue:@"rating"]).to.equal(PKTNotificationTypeRating);
  expect([transformer transformedValue:@"message"]).to.equal(PKTNotificationTypeMessage);
  expect([transformer transformedValue:@"space_invite"]).to.equal(PKTNotificationTypeSpaceInvite);
  expect([transformer transformedValue:@"space_delete"]).to.equal(PKTNotificationTypeSpaceDelete);
  expect([transformer transformedValue:@"bulletin"]).to.equal(PKTNotificationTypeBulletin);
  expect([transformer transformedValue:@"member_reference_add"]).to.equal(PKTNotificationTypeMemberReferenceAdd);
  expect([transformer transformedValue:@"member_reference_remove"]).to.equal(PKTNotificationTypeMemberReferenceRemove);
  expect([transformer transformedValue:@"file"]).to.equal(PKTNotificationTypeFile);
  expect([transformer transformedValue:@"role_change"]).to.equal(PKTNotificationTypeRoleChange);
  expect([transformer transformedValue:@"conversation_add"]).to.equal(PKTNotificationTypeConversationAdd);
  expect([transformer transformedValue:@"answer"]).to.equal(PKTNotificationTypeAnswer);
  expect([transformer transformedValue:@"self_kicked_from_space"]).to.equal(PKTNotificationTypeSelfKickedFromSpace);
  expect([transformer transformedValue:@"space_create"]).to.equal(PKTNotificationTypeSpaceCreate);
  expect([transformer transformedValue:@"meeting_participant_add"]).to.equal(PKTNotificationTypeMeetingParticipantAdd);
  expect([transformer transformedValue:@"meeting_participant_remove"]).to.equal(PKTNotificationTypeMeetingParticipantRemove);
  expect([transformer transformedValue:@"reminder"]).to.equal(PKTNotificationTypeReminder);
  expect([transformer transformedValue:@"batch_process"]).to.equal(PKTNotificationTypeBatchProcess);
  expect([transformer transformedValue:@"batch_complete"]).to.equal(PKTNotificationTypeBatchComplete);
  expect([transformer transformedValue:@"space_member_request"]).to.equal(PKTNotificationTypeSpaceMemberRequest);
  expect([transformer transformedValue:@"grant_create"]).to.equal(PKTNotificationTypeGrantCreate);
  expect([transformer transformedValue:@"grant_delete"]).to.equal(PKTNotificationTypeGrantDelete);
  expect([transformer transformedValue:@"grant_create_other"]).to.equal(PKTNotificationTypeGrantCreateOther);
  expect([transformer transformedValue:@"grant_delete_other"]).to.equal(PKTNotificationTypeGrantDeleteOther);
  expect([transformer transformedValue:@"reference"]).to.equal(PKTNotificationTypeReference);
  expect([transformer transformedValue:@"like"]).to.equal(PKTNotificationTypeLike);
  expect([transformer transformedValue:@"vote"]).to.equal(PKTNotificationTypeVote);
  expect([transformer transformedValue:@"participation"]).to.equal(PKTNotificationTypeParticipation);
  expect([transformer transformedValue:@"file_delete"]).to.equal(PKTNotificationTypeFileDelete);
}

@end
