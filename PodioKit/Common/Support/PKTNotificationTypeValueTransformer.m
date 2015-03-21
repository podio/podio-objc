//
//  PKTNotificationTypeValueTransformer.m
//  PodioKit
//
//  Created by Romain Briche on 21/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationTypeValueTransformer.h"
#import "PKTConstants.h"

@implementation PKTNotificationTypeValueTransformer

- (instancetype)init {
  return [super initWithDictionary:@{
    @"alert": @(PKTNotificationTypeAlert),
    @"team_alert": @(PKTNotificationTypeTeamAlert),
    @"creation": @(PKTNotificationTypeCreation),
    @"update": @(PKTNotificationTypeUpdate),
    @"delete": @(PKTNotificationTypeDelete),
    @"comment": @(PKTNotificationTypeComment),
    @"rating": @(PKTNotificationTypeRating),
    @"message": @(PKTNotificationTypeMessage),
    @"space_invite": @(PKTNotificationTypeSpaceInvite),
    @"space_delete": @(PKTNotificationTypeSpaceDelete),
    @"bulletin": @(PKTNotificationTypeBulletin),
    @"member_reference_add": @(PKTNotificationTypeMemberReferenceAdd),
    @"member_reference_remove": @(PKTNotificationTypeMemberReferenceRemove),
    @"file": @(PKTNotificationTypeFile),
    @"role_change": @(PKTNotificationTypeRoleChange),
    @"conversation_add": @(PKTNotificationTypeConversationAdd),
    @"answer": @(PKTNotificationTypeAnswer),
    @"self_kicked_from_space": @(PKTNotificationTypeSelfKickedFromSpace),
    @"space_create": @(PKTNotificationTypeSpaceCreate),
    @"meeting_participant_add": @(PKTNotificationTypeMeetingParticipantAdd),
    @"meeting_participant_remove": @(PKTNotificationTypeMeetingParticipantRemove),
    @"reminder": @(PKTNotificationTypeReminder),
    @"batch_process": @(PKTNotificationTypeBatchProcess),
    @"batch_complete": @(PKTNotificationTypeBatchComplete),
    @"space_member_request": @(PKTNotificationTypeSpaceMemberRequest),
    @"grant_create": @(PKTNotificationTypeGrantCreate),
    @"grant_delete": @(PKTNotificationTypeGrantDelete),
    @"grant_create_other": @(PKTNotificationTypeGrantCreateOther),
    @"grant_delete_other": @(PKTNotificationTypeGrantDeleteOther),
    @"reference": @(PKTNotificationTypeReference),
    @"like": @(PKTNotificationTypeLike),
    @"vote": @(PKTNotificationTypeVote),
    @"participation": @(PKTNotificationTypeParticipation),
    @"file_delete": @(PKTNotificationTypeFileDelete)
  }];
}

@end
