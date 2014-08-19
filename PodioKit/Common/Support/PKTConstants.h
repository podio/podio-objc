//
//  PKTConstants.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#ifndef PodioKit_PKTConstants_h
#define PodioKit_PKTConstants_h

typedef NS_ENUM(NSUInteger, PKTReferenceType) {
  PKTReferenceTypeUnknown = 0,
  PKTReferenceTypeApp,
  PKTReferenceTypeAppRevision,
  PKTReferenceTypeAppField,
  PKTReferenceTypeItem,
  PKTReferenceTypeBulletin,
  PKTReferenceTypeComment,
  PKTReferenceTypeStatus,
  PKTReferenceTypeSpaceMember,
  PKTReferenceTypeAlert,
  PKTReferenceTypeItemRevision,
  PKTReferenceTypeRating,
  PKTReferenceTypeTask,
  PKTReferenceTypeTaskAction,
  PKTReferenceTypeSpace,
  PKTReferenceTypeOrg,
  PKTReferenceTypeConversation,
  PKTReferenceTypeMessage,
  PKTReferenceTypeNotification,
  PKTReferenceTypeFile,
  PKTReferenceTypeFileService,
  PKTReferenceTypeProfile,
  PKTReferenceTypeUser,
  PKTReferenceTypeWidget,
  PKTReferenceTypeShare,
  PKTReferenceTypeForm,
  PKTReferenceTypeAuthClient,
  PKTReferenceTypeConnection,
  PKTReferenceTypeIntegration,
  PKTReferenceTypeShareInstall,
  PKTReferenceTypeIcon,
  PKTReferenceTypeOrgMember,
  PKTReferenceTypeNews,
  PKTReferenceTypeHook,
  PKTReferenceTypeTag,
  PKTReferenceTypeEmbed,
  PKTReferenceTypeQuestion,
  PKTReferenceTypeQuestionAnswer,
  PKTReferenceTypeAction,
  PKTReferenceTypeContract,
  PKTReferenceTypeMeeting,
  PKTReferenceTypeBatch,
  PKTReferenceTypeSystem,
  PKTReferenceTypeSpaceMemberRequest,
  PKTReferenceTypeLive,
  PKTReferenceTypeItemParticipation
};

#pragma mark - Workspaces

typedef NS_ENUM(NSUInteger, PKTWorkspacePrivacy) {
  PKTWorkspacePrivacyUnknown = 0,
  PKTWorkspacePrivacyOpen,
  PKTWorkspacePrivacyClosed
};

typedef NS_ENUM(NSUInteger, PKTWorkspaceMemberRole) {
  PKTWorkspaceMemberRoleUnknown = 0,
  PKTWorkspaceMemberRoleLight,
  PKTWorkspaceMemberRoleRegular,
  PKTWorkspaceMemberRoleAdmin
};

typedef NS_ENUM(NSUInteger, PKTWorkspaceType) {
  PKTWorkspaceTypeUnknown = 0,
  PKTWorkspaceTypeRegular,
  PKTWorkspaceTypeEmployeeNetwork,
  PKTWorkspaceTypeDemo
};

#pragma mark - Apps

typedef NS_ENUM(NSUInteger, PKTAppFieldType) {
  PKTAppFieldTypeUnknown = 0,
  PKTAppFieldTypeText,
  PKTAppFieldTypeNumber,
  PKTAppFieldTypeImage,
  PKTAppFieldTypeDate,
  PKTAppFieldTypeApp,
  PKTAppFieldTypeContact,
  PKTAppFieldTypeMoney,
  PKTAppFieldTypeProgress,
  PKTAppFieldTypeLocation,
  PKTAppFieldTypeDuration,
  PKTAppFieldTypeEmbed,
  PKTAppFieldTypeCalculation,
  PKTAppFieldTypeCategory,
};

typedef NS_ENUM(NSUInteger, PKTCategoryOptionStatus) {
  PKTCategoryOptionStatusUnknown = 0,
  PKTCategoryOptionStatusActive,
  PKTCategoryOptionStatusDeleted
};

typedef NS_ENUM(NSInteger, PKTEmbedType) {
  PKTEmbedTypeUnknown = 0,
  PKTEmbedTypeImage,
  PKTEmbedTypeVideo,
  PKTEmbedTypeRich,
  PKTEmbedTypeLink,
  PKTEmbedTypeUnresolved
};

#pragma mark - Tasks

typedef NS_ENUM(NSUInteger, PKTTaskStatus) {
  PKTTaskStatusActive,
  PKTTaskStatusCompleted,
};

#endif
