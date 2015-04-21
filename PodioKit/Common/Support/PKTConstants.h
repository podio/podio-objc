//
//  PKTConstants.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#ifndef PodioKit_PKTConstants_h
#define PodioKit_PKTConstants_h

#pragma mark - Rights

typedef NS_OPTIONS(NSUInteger, PKTRight) {
  PKTRightNone                  = 0,
  PKTRightView                  = 1 << 0,
  PKTRightUpdate                = 1 << 1,
  PKTRightDelete                = 1 << 2,
  PKTRightSubscribe             = 1 << 3,
  PKTRightComment               = 1 << 4,
  PKTRightRate                  = 1 << 5,
  PKTRightShare                 = 1 << 6,
  PKTRightInstall               = 1 << 7,
  PKTRightAddApp                = 1 << 8,
  PKTRightAddItem               = 1 << 9,
  PKTRightAddFile               = 1 << 10,
  PKTRightAddTask               = 1 << 11,
  PKTRightAddSpace              = 1 << 12,
  PKTRightAddStatus             = 1 << 13,
  PKTRightAddConversation       = 1 << 14,
  PKTRightReply                 = 1 << 15,
  PKTRightAddWidget             = 1 << 16,
  PKTRightStatistics            = 1 << 17,
  PKTRightAddContact            = 1 << 18,
  PKTRightAddHook               = 1 << 19,
  PKTRightAddQuestion           = 1 << 20,
  PKTRightAddAnswer             = 1 << 21,
  PKTRightAddContract           = 1 << 22,
  PKTRightAddUser               = 1 << 23,
  PKTRightAddUserLight          = 1 << 24,
  PKTRightMove                  = 1 << 25,
  PKTRightExport                = 1 << 26,
  PKTRightReference             = 1 << 27,
  PKTRightViewAdmins            = 1 << 28,
  PKTRightDownload              = 1 << 29,
  PKTRightGrant                 = 1 << 30,
  PKTRightGrantView             = 1 << 31
};

#pragma mark - References

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

#pragma mark - Notifications

typedef NS_ENUM(NSInteger, PKTNotificationType) {
  PKTNotificationTypeUnknown = 0,
  PKTNotificationTypeAlert,
  PKTNotificationTypeTeamAlert,
  PKTNotificationTypeCreation,
  PKTNotificationTypeUpdate,
  PKTNotificationTypeDelete,
  PKTNotificationTypeComment,
  PKTNotificationTypeRating,
  PKTNotificationTypeMessage,
  PKTNotificationTypeSpaceInvite,
  PKTNotificationTypeSpaceDelete,
  PKTNotificationTypeBulletin,
  PKTNotificationTypeMemberReferenceAdd,
  PKTNotificationTypeMemberReferenceRemove,
  PKTNotificationTypeFile,
  PKTNotificationTypeRoleChange,
  PKTNotificationTypeConversationAdd,
  PKTNotificationTypeAnswer,
  PKTNotificationTypeSelfKickedFromSpace,
  PKTNotificationTypeSpaceCreate,
  PKTNotificationTypeMeetingParticipantAdd,
  PKTNotificationTypeMeetingParticipantRemove,
  PKTNotificationTypeReminder,
  PKTNotificationTypeBatchProcess,
  PKTNotificationTypeBatchComplete,
  PKTNotificationTypeSpaceMemberRequest,
  PKTNotificationTypeGrantCreate,
  PKTNotificationTypeGrantDelete,
  PKTNotificationTypeGrantCreateOther,
  PKTNotificationTypeGrantDeleteOther,
  PKTNotificationTypeReference,
  PKTNotificationTypeLike,
  PKTNotificationTypeVote,
  PKTNotificationTypeParticipation,
  PKTNotificationTypeFileDelete
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

typedef NS_ENUM(NSUInteger, PKTImageSize) {
  PKTImageSizeOriginal,
  PKTImageSizeDefault,     // 40x40
  PKTImageSizeTiny,        // 16x16
  PKTImageSizeSmall,       // 32x32
  PKTImageSizeMedium,      // 80x80
  PKTImageSizeLarge,       // 160x160
  PKTImageSizeExtraLarge,  // 520x?
};

#pragma mark - Tasks

typedef NS_ENUM(NSUInteger, PKTTaskStatus) {
  PKTTaskStatusActive,
  PKTTaskStatusCompleted,
};

#pragma mark - Avatar

typedef NS_ENUM(NSUInteger, PKTAvatarType) {
  PKTAvatarTypeUnknown = 0,
  PKTAvatarTypeFile,
  PKTAvatarTypeIcon
};

#endif
