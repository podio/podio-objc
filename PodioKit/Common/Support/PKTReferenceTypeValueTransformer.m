//
//  PKTReferenceTypeValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReferenceTypeValueTransformer.h"
#import "PKTConstants.h"

@implementation PKTReferenceTypeValueTransformer

- (instancetype)init {
  return [super initWithDictionary:@{
    @"app" : @(PKTReferenceTypeApp),
    @"app_revision" : @(PKTReferenceTypeAppRevision),
    @"app_field" : @(PKTReferenceTypeAppField),
    @"item" : @(PKTReferenceTypeItem),
    @"bulletin" : @(PKTReferenceTypeBulletin),
    @"comment" : @(PKTReferenceTypeComment),
    @"status" : @(PKTReferenceTypeStatus),
    @"space_member" : @(PKTReferenceTypeSpaceMember),
    @"alert" : @(PKTReferenceTypeAlert),
    @"item_revision" : @(PKTReferenceTypeItemRevision),
    @"rating" : @(PKTReferenceTypeRating),
    @"task" : @(PKTReferenceTypeTask),
    @"task_action" : @(PKTReferenceTypeTaskAction),
    @"space" : @(PKTReferenceTypeSpace),
    @"org" : @(PKTReferenceTypeOrg),
    @"conversation" : @(PKTReferenceTypeConversation),
    @"message" : @(PKTReferenceTypeMessage),
    @"notification" : @(PKTReferenceTypeNotification),
    @"file" : @(PKTReferenceTypeFile),
    @"file_service" : @(PKTReferenceTypeFileService),
    @"profile" : @(PKTReferenceTypeProfile),
    @"user" : @(PKTReferenceTypeUser),
    @"widget" : @(PKTReferenceTypeWidget),
    @"share" : @(PKTReferenceTypeShare),
    @"form" : @(PKTReferenceTypeForm),
    @"auth_client" : @(PKTReferenceTypeAuthClient),
    @"connection" : @(PKTReferenceTypeConnection),
    @"integration" : @(PKTReferenceTypeIntegration),
    @"share_install" : @(PKTReferenceTypeShareInstall),
    @"icon" : @(PKTReferenceTypeIcon),
    @"org_member" : @(PKTReferenceTypeOrgMember),
    @"news" : @(PKTReferenceTypeNews),
    @"hook" : @(PKTReferenceTypeHook),
    @"tag" : @(PKTReferenceTypeTag),
    @"embed" : @(PKTReferenceTypeEmbed),
    @"question" : @(PKTReferenceTypeQuestion),
    @"question_answer" : @(PKTReferenceTypeQuestionAnswer),
    @"action" : @(PKTReferenceTypeAction),
    @"contract" : @(PKTReferenceTypeContract),
    @"meeting" : @(PKTReferenceTypeMeeting),
    @"batch" : @(PKTReferenceTypeBatch),
    @"system" : @(PKTReferenceTypeSystem),
    @"space_member_request" : @(PKTReferenceTypeSpaceMemberRequest),
    @"live" : @(PKTReferenceTypeLive),
    @"item_participation" : @(PKTReferenceTypeItemParticipation),
  }];
}

@end
