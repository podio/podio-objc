//
//  PKConstants.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/28/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Errors and exceptions

typedef enum {
  PKErrorCodeNoConnection = 1001,
  PKErrorCodeNotAuthenticated = 1002,
  PKErrorCodeParsingFailed = 1003,
  PKErrorCodeMultipleRequests = 1004,
  PKErrorCodeRequestCancelled = 1005,
  PKErrorCodeServerError = 2000,
} PKErrorCode;

#pragma mark - Contact

static NSString* const kPKContactTypeContact = @"space";
static NSString* const kPKContactTypeUser = @"user";
static NSString* const kPKContactTypeConnection = @"connection";

static NSString * const kPKUserTypeUser = @"user";
static NSString * const kPKUserTypeApp = @"app";

typedef NS_ENUM(NSUInteger, PKRight) {
  PKRightNone            = 0,
  PKRightView            = 1 << 0,
  PKRightUpdate          = 1 << 1,
  PKRightDelete          = 1 << 2,
  PKRightSubscribe       = 1 << 3,
  PKRightComment         = 1 << 4,
  PKRightRate            = 1 << 5,
  PKRightShare           = 1 << 6,
  PKRightInstall         = 1 << 7,
  PKRightAddApp          = 1 << 8,
  PKRightAddItem         = 1 << 9,
  PKRightAddFile         = 1 << 10,
  PKRightAddTask         = 1 << 11,
  PKRightAddSpace        = 1 << 12,
  PKRightAddStatus       = 1 << 13,
  PKRightAddConversation = 1 << 14,
  PKRightReply           = 1 << 15,
  PKRightAddFilter       = 1 << 16,
  PKRightAddWidget       = 1 << 17,
  PKRightStatistics      = 1 << 18,
  PKRightAddContact      = 1 << 19,
  PKRightAddHook         = 1 << 20,
  PKRightAddQuestion     = 1 << 21,
  PKRightAddAnswer       = 1 << 22,
  PKRightAddContract     = 1 << 23,
  PKRightAddUser         = 1 << 24,
  PKRightAddUserLight    = 1 << 25,
  PKRightMove            = 1 << 26,
  PKRightExport          = 1 << 27,
  PKRightReference       = 1 << 28,
  PKRightViewAdmins      = 1 << 29,
  PKRightDownload        = 1 << 30,
  PKRightGrant           = 1 << 31,
};

#pragma mark - Role

typedef NS_ENUM(NSUInteger, PKRole) {
  PKRoleNone = 0,
  PKRoleLight,
  PKRoleRegular,
  PKRoleAdmin,
};

static NSString * const kPKRoleLight = @"light";
static NSString * const kPKRoleRegular = @"regular";
static NSString * const kPKRoleAdmin = @"admin";


#pragma mark - Spaces

typedef enum {
  PKSpaceTypeNone = 0,
  PKSpaceTypeRegular,
  PKSpaceTypeDemo,
  PKSpaceTypeEmployeeNetwork,
} PKSpaceType;

static NSString * const kPKSpaceTypeRegular = @"regular";
static NSString * const kPKSpaceTypeDemo = @"demo";
static NSString * const kPKSpaceTypeEmployeeNetwork = @"emp_network";

typedef enum {
  PKSpaceCreateStatusNone = 0,
  PKSpaceCreateStatusJoined,
  PKSpaceCreateStatusOpen,
  PKSpaceCreateStatusClosed,
  PKSpaceCreateStatusDeleted,
} PKSpaceCreateStatus;

static NSString * const kPKSpaceCreateStatusJoined = @"joined";
static NSString * const kPKSpaceCreateStatusOpen = @"open";
static NSString * const kPKSpaceCreateStatusClosed = @"closed";
static NSString * const kPKSpaceCreateStatusDeleted = @"deleted";

typedef enum {
  PKSpaceMemberRequestStatusNone = 0,
  PKSpaceMemberRequestStatusActive,
  PKSpaceMemberRequestStatusAccepted,
} PKSpaceMemberRequestStatus;

static NSString * const kPKSpaceMemberRequestStatusActive = @"active";
static NSString * const kPKSpaceMemberRequestStatusAccepted = @"accepted";

#pragma mark - Tasks

typedef enum {
  PKTaskTypeNone = 0,
  PKTaskTypeActive,
  PKTaskTypeDelegated,
  PKTaskTypeCompleted,
} PKTaskType;

typedef enum {
  PKTaskStatusNone = 0,
  PKTaskStatusActive = 1,
  PKTaskStatusCompleted = 2,
  PKTaskStatusDeleted = 3,
} PKTaskStatus;

static NSString * const kPKTaskStatusActive = @"active";
static NSString * const kPKTaskStatusCompleted = @"completed";
static NSString * const kPKTaskStatusDeleted = @"deleted";

typedef enum {
  PKTaskActionTypeNone = 0,
  PKTaskActionTypeCreation = 1,
  PKTaskActionTypeStart = 2,
  PKTaskActionTypeStop = 3,
  PKTaskActionTypeAssign = 4,
  PKTaskActionTypeComplete = 5,
  PKTaskActionTypeIncomplete = 6,
  PKTaskActionTypeUpdateText = 7,
  PKTaskActionTypeUpdateDescription = 8,
  PKTaskActionTypeUpdateDueDate = 9,
  PKTaskActionTypeUpdatePrivate = 10,
  PKTaskActionTypeDelete = 11,
  PKTaskActionTypeUpdateRef = 12,
} PKTaskActionType;

static NSString * const kPKTaskActionTypeCreation = @"creation";
static NSString * const kPKTaskActionTypeStart = @"start";
static NSString * const kPKTaskActionTypeStop = @"stop";
static NSString * const kPKTaskActionTypeAssign = @"assign";
static NSString * const kPKTaskActionTypeComplete = @"complete";
static NSString * const kPKTaskActionTypeIncomplete = @"incomplete";
static NSString * const kPKTaskActionTypeUpdateText = @"update_text";
static NSString * const kPKTaskActionTypeUpdateDescription = @"update_description";
static NSString * const kPKTaskActionTypeUpdateDueDate = @"update_due_date";
static NSString * const kPKTaskActionTypeUpdatePrivate = @"update_private";
static NSString * const kPKTaskActionTypeDelete = @"delete";
static NSString * const kPKTaskActionTypeUpdateRef = @"update_ref";

// Task groupings
typedef enum {
  PKTaskGroupNone = 0,
  PKTaskGroupOverdue,
  PKTaskGroupToday,
  PKTaskGroupTomorrow,
  PKTaskGroupUpcoming,
  PKTaskGroupLater,
  
  PKTaskGroup1Day,
  PKTaskGroup2Day,
  PKTaskGroup3Day,
  PKTaskGroup4Day,
  PKTaskGroup5Day,
  PKTaskGroup6Day,
  PKTaskGroup1Week,
  PKTaskGroup2Week,
  PKTaskGroup3Week,
  PKTaskGroup4Week,
  PKTaskGroup1Month,
  PKTaskGroup2Month,
  PKTaskGroup3Month,
  PKTaskGroup4Month,
  PKTaskGroup5Month,
  PKTaskGroup6Month,
  PKTaskGroup7Month,
  PKTaskGroup8Month,
  PKTaskGroup9Month,
  PKTaskGroup10Month,
  PKTaskGroup11Month,
  PKTaskGroup12Month,
  PKTaskGroup1Year,
  PKTaskGroupOlder,
} PKTaskGroup;

static NSString * const kPKTaskGroupOverdue = @"overdue";
static NSString * const kPKTaskGroupToday = @"today";
static NSString * const kPKTaskGroupTomorrow = @"tomorrow";
static NSString * const kPKTaskGroupUpcoming = @"upcoming";
static NSString * const kPKTaskGroupLater = @"later";

static NSString * const kPKTaskGroup1Day = @"1_day";
static NSString * const kPKTaskGroup2Day = @"2_days";
static NSString * const kPKTaskGroup3Day = @"3_days";
static NSString * const kPKTaskGroup4Day = @"4_days";
static NSString * const kPKTaskGroup5Day = @"5_days";
static NSString * const kPKTaskGroup6Day = @"6_days";
static NSString * const kPKTaskGroup1Week = @"1_week";
static NSString * const kPKTaskGroup2Week = @"2_weeks";
static NSString * const kPKTaskGroup3Week = @"3_weeks";
static NSString * const kPKTaskGroup4Week = @"4_weeks";
static NSString * const kPKTaskGroup1Month = @"1_month";
static NSString * const kPKTaskGroup2Month = @"2_months";
static NSString * const kPKTaskGroup3Month = @"3_months";
static NSString * const kPKTaskGroup4Month = @"4_months";
static NSString * const kPKTaskGroup5Month = @"5_months";
static NSString * const kPKTaskGroup6Month = @"6_months";
static NSString * const kPKTaskGroup7Month = @"7_months";
static NSString * const kPKTaskGroup8Month = @"8_months";
static NSString * const kPKTaskGroup9Month = @"9_months";
static NSString * const kPKTaskGroup10Month = @"10_months";
static NSString * const kPKTaskGroup11Month = @"11_months";
static NSString * const kPKTaskGroup12Month = @"12_months";
static NSString * const kPKTaskGroup1Year = @"1_year";
static NSString * const kPKTaskGroupOlder = @"older";

// Task totals
typedef enum {
  PKTaskTotalsTimeOverdue = 0,
  PKTaskTotalsTimeDue,
  PKTaskTotalsTimeToday,
  PKTaskTotalsTimeAll,
} PKTaskTotalsTime;

#pragma mark - App

typedef enum {
  PKAppTypeNone,
  PKAppTypeStandard,
  PKAppTypeMeeting,
} PKAppType;

static NSString * const kPKAppTypeStandard = @"standard";
static NSString * const kPKAppTypeMeeting = @"meeting";

#pragma mark - Item

// Field types
typedef enum {
  PKAppFieldTypeNone = 0,
  PKAppFieldTypeTitle,
  PKAppFieldTypeText, 
  PKAppFieldTypeNumber,
  PKAppFieldTypeImage,
  PKAppFieldTypeDate,
  PKAppFieldTypeApp,
  PKAppFieldTypeMember,
  PKAppFieldTypeContact,
  PKAppFieldTypeMoney,
  PKAppFieldTypeProgress,
  PKAppFieldTypeLocation,
  PKAppFieldTypeVideo,
  PKAppFieldTypeDuration,
  PKAppFieldTypeEmbed,
  PKAppFieldTypeCalculation,
  PKAppFieldTypeCategory,
  PKAppFieldTypePhone,
  PKAppFieldTypeEmail,
  PKAppFieldTypeTag
} PKAppFieldType;

static NSString * const kPKAppFieldTypeTitle = @"title";
static NSString * const kPKAppFieldTypeText = @"text";
static NSString * const kPKAppFieldTypeNumber = @"number";
static NSString * const kPKAppFieldTypeState = @"state";
static NSString * const kPKAppFieldTypeImage = @"image";
static NSString * const kPKAppFieldTypeMedia = @"media";
static NSString * const kPKAppFieldTypeDate = @"date";
static NSString * const kPKAppFieldTypeApp = @"app";
static NSString * const kPKAppFieldTypeMember = @"member";
static NSString * const kPKAppFieldTypeContact = @"contact";
static NSString * const kPKAppFieldTypeMoney = @"money";
static NSString * const kPKAppFieldTypeProgress = @"progress";
static NSString * const kPKAppFieldTypeLocation = @"location";
static NSString * const kPKAppFieldTypeVideo = @"video";
static NSString * const kPKAppFieldTypeDuration = @"duration";
static NSString * const kPKAppFieldTypeEmbed = @"embed";
static NSString * const kPKAppFieldTypeCalculation = @"calculation";
static NSString * const kPKAppFieldTypeQuestion = @"question";
static NSString * const kPKAppFieldTypeCategory = @"category";
static NSString * const kPKAppFieldTypePhone = @"phone";
static NSString * const kPKAppFieldTypeEmail = @"email";
static NSString * const kPKAppFieldTypeTag = @"tag";

typedef enum {
  PKAppFieldStatusNone,
  PKAppFieldStatusActive,
  PKAppFieldStatusInactive,
  PKAppFieldStatusDeleted,
} PKAppFieldStatus;

static NSString * const kPKAppFieldStatusActive = @"active";
static NSString * const kPKAppFieldStatusInactive = @"inactive";
static NSString * const kPKAppFieldStatusDeleted = @"deleted";

// Item revision
typedef enum {
  PKItemRevisionTypeNone = 0,
  PKItemRevisionTypeCreation = 1,
  PKItemRevisionTypeUpdate = 2, 
  PKItemRevisionTypeDelete = 3,
} PKItemRevisionType;

static NSString * const kPKItemRevisionTypeCreation = @"creation";
static NSString * const kPKItemRevisionTypeUpdate = @"update";
static NSString * const kPKItemRevisionTypeDelete = @"delete";

// App field mapping
typedef enum {
  PKAppFieldMappingNone,
  PKAppFieldMappingMeetingTime,
  PKAppFieldMappingMeetingParticipants,
  PKAppFieldMappingMeetingAgenda,
  PKAppFieldMappingMeetingLocation,
} PKAppFieldMapping;

static NSString * const kPKAppFieldMappingMeetingTime = @"meeting_time";
static NSString * const kPKAppFieldMappingMeetingParticipants = @"meeting_participants";
static NSString * const kPKAppFieldMappingMeetingAgenda = @"meeting_agenda";
static NSString * const kPKAppFieldMappingMeetingLocation = @"meeting_location";

#pragma mark - Conversation

typedef enum {
  PKConversationTypeNone,
  PKConversationTypeDirect,
  PKConversationTypeGroup,
} PKConversationType;

static NSString * const kPKConversationTypeDirect = @"direct";
static NSString * const kPKConversationTypeGroup = @"group";

typedef enum {
  PKConversationEventActionNone,
  PKConversationEventActionMessage,
  PKConversationEventActionParticipantAdd,
  PKConversationEventActionParticipantLeave,
  PKConversationEventActionLiveStart,
  PKConversationEventActionLiveEnd,
  PKConversationEventActionLiveAccept,
  PKConversationEventActionLiveDecline,
  PKConversationEventActionSubjectChange,
} PKConversationEventAction;

static NSString * const kPKConversationEventActionMessage = @"message";
static NSString * const kPKConversationEventActionParticipantAdd = @"participant_add";
static NSString * const kPKConversationEventActionParticipantLeave = @"participant_leave";
static NSString * const kPKConversationEventActionLiveStart = @"live_start";
static NSString * const kPKConversationEventActionLiveEnd = @"live_end";
static NSString * const kPKConversationEventActionLiveAccept = @"live_accept";
static NSString * const kPKConversationEventActionLiveDecline = @"live_decline";
static NSString * const kPKConversationEventActionSubjectChange = @"subject_change";

#pragma mark - Stream

typedef enum {
  PKStreamActivityTypeNone = 0,
  PKStreamActivityTypeComment,
  PKStreamActivityTypeFile,
  PKStreamActivityTypeVote,
  PKStreamActivityTypeRating,
  PKStreamActivityTypeCreation,
  PKStreamActivityTypeUpdate,
  PKStreamActivityTypeTask,
  PKStreamActivityTypeAnswer,
  PKStreamActivityTypeParticipation,
  PKStreamActivityTypeGrant,
  PKStreamActivityTypeFileDelete,
} PKStreamActivityType;

static NSString * const kPKStreamActivityTypeComment = @"comment";
static NSString * const kPKStreamActivityTypeFile = @"file";
static NSString * const kPKStreamActivityTypeVote = @"vote";
static NSString * const kPKStreamActivityTypeRating = @"rating";
static NSString * const kPKStreamActivityTypeCreation = @"creation";
static NSString * const kPKStreamActivityTypeUpdate = @"update";
static NSString * const kPKStreamActivityTypeTask = @"task";
static NSString * const kPKStreamActivityTypeAnswer = @"answer";
static NSString * const kPKStreamActivityTypeParticipation = @"participation";
static NSString * const kPKStreamActivityTypeGrant = @"grant";
static NSString * const kPKStreamActivityTypeFileDelete = @"file_delete";

#pragma mark - Action

typedef enum {
  PKActionTypeNone = 0,
  PKActionTypeSpaceCreated = 1,
  PKActionTypeMemberAdded = 2,
  PKActionTypeMemberLeft = 3,
  PKActionTypeMemberKicked = 4,
  PKActionTypeAppCreated = 5,
  PKActionTypeAppInstalled = 6,
  PKActionTypeAppUpdated = 7,
  PKActionTypeAppDeactivated = 8,
  PKActionTypeAppActivated = 9,
  PKActionTypeAppDeleted = 10,
  PKActionTypeMemberJoined = 11,
  PKActionTypeSpaceArchived = 12,
  PKActionTypeSpaceRestored = 13,
} PKActionType;

static NSString * const kPKActionTypeSpaceCreated = @"space_created";
static NSString * const kPKActionTypeMemberAdded = @"member_added";
static NSString * const kPKActionTypeMemberLeft = @"member_left";
static NSString * const kPKActionTypeMemberKicked = @"member_kicked";
static NSString * const kPKActionTypeAppCreated = @"app_created";
static NSString * const kPKActionTypeAppInstalled = @"app_installed";
static NSString * const kPKActionTypeAppUpdated = @"app_updated";
static NSString * const kPKActionTypeAppDeactivated = @"app_deactivated";
static NSString * const kPKActionTypeAppActivated = @"app_activated";
static NSString * const kPKActionTypeAppDeleted = @"app_deleted";
static NSString * const kPKActionTypeMemberJoined = @"member_joined";
static NSString * const kPKActionTypeSpaceArchived = @"space_archived";
static NSString * const kPKActionTypeSpaceRestored = @"space_restored";

#pragma mark - Vote

typedef enum {
  PKVoteTypeNone = 0,
  PKVoteTypeAnswer,
  PKVoteTypeFivestar,
} PKVoteType;

static NSString * const kPKVoteTypeAnswer = @"answer";
static NSString * const kPKVoteTypeFivestar = @"fivestar";

#pragma mark - Rating

typedef enum {
  PKRatingTypeNone = 0,
  PKRatingTypeApproved,
  PKRatingTypeRSVP,
  PKRatingTypeYesNo,
  PKRatingTypeThumbs,
  PKRatingTypeLike,
} PKRatingType;

static NSString * const kPKRatingTypeApproved = @"approved";
static NSString * const kPKRatingTypeRSVP = @"rsvp";
static NSString * const kPKRatingTypeYesNo = @"yesno";
static NSString * const kPKRatingTypeThumbs = @"thumbs";
static NSString * const kPKRatingTypeLike = @"like";

#pragma mark - Grant

typedef NS_ENUM(NSInteger, PKGrantAction) {
  PKGrantActionNone = 0,
  PKGrantActionView,
  PKGrantActionComment,
  PKGrantActionRate
};

static NSString * const kPKGrantActionView = @"view";
static NSString * const kPKGrantActionComment = @"comment";
static NSString * const kPKGrantActionRate = @"rate";

#pragma mark - Reference

typedef enum {
  PKReferenceTypeNone = 0,
  PKReferenceTypeApp,
  PKReferenceTypeAppRevision,
  PKReferenceTypeAppField,
  PKReferenceTypeItem,
  PKReferenceTypeBulletin,
  PKReferenceTypeComment,
  PKReferenceTypeStatus,
  PKReferenceTypeSpaceMember,
  PKReferenceTypeAlert,
  PKReferenceTypeItemRevision,
  PKReferenceTypeVote,
  PKReferenceTypeRating,
  PKReferenceTypeTask,
  PKReferenceTypeTaskAction,
  PKReferenceTypeSpace,
  PKReferenceTypeOrg,
  PKReferenceTypeConversation,
  PKReferenceTypeMessage,
  PKReferenceTypeNotification,
  PKReferenceTypeFile,
  PKReferenceTypeFileService,
  PKReferenceTypeProfile,
  PKReferenceTypeUser,
  PKReferenceTypeWidget,
  PKReferenceTypeShare,
  PKReferenceTypeForm,
  PKReferenceTypeAuthClient,
  PKReferenceTypeConnection,
  PKReferenceTypeIntegration,
  PKReferenceTypeShareInstall,
  PKReferenceTypeIcon,
  PKReferenceTypeOrgMember,
  PKReferenceTypeNews,
  PKReferenceTypeHook,
  PKReferenceTypeTag,
  PKReferenceTypeEmbed,
  PKReferenceTypeQuestion,
  PKReferenceTypeQuestionAnswer,
  PKReferenceTypeAction,
  PKReferenceTypeContract,
//  PKReferenceTypeInvoice,
//  PKReferenceTypePayment,
  PKReferenceTypeMeeting,
  PKReferenceTypeBatch,
  PKReferenceTypeSystem,
  PKReferenceTypeSpaceMemberRequest,
  PKReferenceTypeLive,
  PKReferenceTypeItemParticipation,
  PKReferenceTypeGrant,
  PKReferenceTypeItemTagField,
} PKReferenceType;

static NSString * const kPKReferenceTypeApp = @"app";
static NSString * const kPKReferenceTypeAppRevision = @"app_revision";
static NSString * const kPKReferenceTypeAppField = @"app_field";
static NSString * const kPKReferenceTypeItem = @"item";
static NSString * const kPKReferenceTypeBulletin = @"bulletin";
static NSString * const kPKReferenceTypeComment = @"comment";
static NSString * const kPKReferenceTypeStatus = @"status";
static NSString * const kPKReferenceTypeSpaceMember = @"space_member";
static NSString * const kPKReferenceTypeAlert = @"alert";
static NSString * const kPKReferenceTypeItemRevision = @"item_revision";
static NSString * const kPKReferenceTypeVote = @"vote";
static NSString * const kPKReferenceTypeRating = @"rating";
static NSString * const kPKReferenceTypeTask = @"task";
static NSString * const kPKReferenceTypeTaskAction = @"task_action";
static NSString * const kPKReferenceTypeSpace = @"space";
static NSString * const kPKReferenceTypeOrg = @"org";
static NSString * const kPKReferenceTypeConversation = @"conversation";
static NSString * const kPKReferenceTypeMessage = @"message";
static NSString * const kPKReferenceTypeNotification = @"notification";
static NSString * const kPKReferenceTypeFile = @"file";
static NSString * const kPKReferenceTypeFileService = @"file_service";
static NSString * const kPKReferenceTypeProfile = @"profile";
static NSString * const kPKReferenceTypeUser = @"user";
static NSString * const kPKReferenceTypeWidget = @"widget";
static NSString * const kPKReferenceTypeShare = @"share";
static NSString * const kPKReferenceTypeForm = @"form";
static NSString * const kPKReferenceTypeAuthClient = @"auth_client";
static NSString * const kPKReferenceTypeConnection = @"connection";
static NSString * const kPKReferenceTypeIntegration = @"integration";
static NSString * const kPKReferenceTypeShareInstall = @"share_install";
static NSString * const kPKReferenceTypeIcon = @"icon";
static NSString * const kPKReferenceTypeOrgMember = @"org_member";
static NSString * const kPKReferenceTypeNews = @"news";
static NSString * const kPKReferenceTypeHook = @"hook";
static NSString * const kPKReferenceTypeTag = @"tag";
static NSString * const kPKReferenceTypeEmbed = @"embed";
static NSString * const kPKReferenceTypeQuestion = @"question";
static NSString * const kPKReferenceTypeQuestionAnswer = @"question_answer";
static NSString * const kPKReferenceTypeAction = @"action";
static NSString * const kPKReferenceTypeContract = @"contract";
static NSString * const kPKReferenceTypeMeeting = @"meeting";
static NSString * const kPKReferenceTypeBatch = @"batch";
static NSString * const kPKReferenceTypeSystem = @"system";
static NSString * const kPKReferenceTypeSpaceMemberRequest = @"space_member_request";
static NSString * const kPKReferenceTypeLive = @"live";
static NSString * const kPKReferenceTypeItemParticipation = @"item_participation";
static NSString * const kPKReferenceTypeGrant = @"grant";

#pragma mark - Notifications

typedef enum {
  PKNotificationTypeNone = 0,
  PKNotificationTypeAlert,
  PKNotificationTypeCreation,
  PKNotificationTypeUpdate,
  PKNotificationTypeDelete,
  PKNotificationTypeComment,
  PKNotificationTypeRating,
  PKNotificationTypeMessage,
  PKNotificationTypeSpaceInvite,
  PKNotificationTypeBulletin,
  PKNotificationTypeMemberReferenceAdd,
  PKNotificationTypeMemberReferenceRemove,
  PKNotificationTypeFile,
  PKNotificationTypeUserLeftSpace,
  PKNotificationTypeUserKickedFromSpace,
  PKNotificationTypeRoleChange,
  PKNotificationTypeRSVP,
  PKNotificationTypeConversationAdd,
  PKNotificationTypeAnswer,
  PKNotificationTypeSelfKickedFromSpace,
  PKNotificationTypeSpaceCreate,
  PKNotificationTypeMeetingStarted,
  PKNotificationTypeMeetingParticipantAdd,
  PKNotificationTypeMeetingParticipantRemove,
  PKNotificationTypeReminder,
  PKNotificationTypeSpaceMemberRequest,
  PKNotificationTypeBatchProcess,
  PKNotificationTypeBatchComplete,
  PKNotificationTypeGrantCreate,
  PKNotificationTypeGrantDelete,
  PKNotificationTypeSpaceDelete,
  PKNotificationTypeParticipation,
} PKNotificationType;

static NSString * const kPKNotificationTypeAlert = @"alert";
static NSString * const kPKNotificationTypeCreation = @"creation";
static NSString * const kPKNotificationTypeUpdate = @"update";
static NSString * const kPKNotificationTypeDelete = @"delete";
static NSString * const kPKNotificationTypeComment = @"comment";
static NSString * const kPKNotificationTypeRating = @"rating";
static NSString * const kPKNotificationTypeMessage = @"message";
static NSString * const kPKNotificationTypeSpaceInvite = @"space_invite";
static NSString * const kPKNotificationTypeBulletin = @"bulletin";
static NSString * const kPKNotificationTypeMemberReferenceAdd = @"member_reference_add";
static NSString * const kPKNotificationTypeMemberReferenceRemove = @"member_reference_remove";
static NSString * const kPKNotificationTypeFile = @"file";
static NSString * const kPKNotificationTypeUserLeftSpace = @"user_left_space";
static NSString * const kPKNotificationTypeUserKickedFromSpace = @"user_kicked_from_space";
static NSString * const kPKNotificationTypeRoleChange = @"role_change";
static NSString * const kPKNotificationTypeRSVP = @"rsvp";
static NSString * const kPKNotificationTypeConversationAdd = @"conversation_add";
static NSString * const kPKNotificationTypeAnswer = @"answer";
static NSString * const kPKNotificationTypeSelfKickedFromSpace = @"self_kicked_from_space";
static NSString * const kPKNotificationTypeSpaceCreate = @"space_create";
static NSString * const kPKNotificationTypeMeetingStarted = @"meeting_started";
static NSString * const kPKNotificationTypeMeetingParticipantAdd = @"meeting_participant_add";
static NSString * const kPKNotificationTypeMeetingParticipantRemove = @"meeting_participant_remove";
static NSString * const kPKNotificationTypeReminder = @"reminder";
static NSString * const kPKNotificationTypeSpaceMemberRequest = @"space_member_request";
static NSString * const kPKNotificationTypeBatchProcess = @"batch_process";
static NSString * const kPKNotificationTypeBatchComplete = @"batch_complete";
static NSString * const kPKNotificationTypeGrantCreate = @"grant_create";
static NSString * const kPKNotificationTypeGrantDelete = @"grant_delete";
static NSString * const kPKNotificationTypeSpaceDelete = @"space_delete";
static NSString * const kPKNotificationTypeParticipation = @"participation";


#pragma mark - Meetings

typedef enum {
  PKExternalMeetingTypeNone = 0,
  PKExternalMeetingTypeGoToMeeting,
  PKExternalMeetingTypeAppearIn,
} PKExternalMeetingType;

static NSString * const kPKExternalMeetingTypeGoToMeeting = @"gotomeeting";
static NSString * const kPKExternalMeetingTypeAppearIn = @"appear_in";

typedef NS_ENUM(NSUInteger, PKMeetingParticipantStatus) {
  PKMeetingParticipantStatusNone,
  PKMeetingParticipantStatusInvited,
  PKMeetingParticipantStatusAccepted,
  PKMeetingParticipantStatusDeclined,
  PKMeetingParticipantStatusTentative,
};

static NSString * const kPKMeetingParticipantStatusInvited = @"invited";
static NSString * const kPKMeetingParticipantStatusAccepted = @"accepted";
static NSString * const kPKMeetingParticipantStatusDeclined = @"declined";
static NSString * const kPKMeetingParticipantStatusTentative = @"tentative";

#pragma mark - Providers

typedef enum {
  PKProviderCapabilityNone = 0,
  PKProviderCapabilityFiles,
  PKProviderCapabilityContacts,
  PKProviderCapabilityMeetings,
} PKProviderCapability;

static NSString * const kPKProviderCapabilityFiles = @"files";
static NSString * const kPKProviderCapabilityContacts = @"contacts";
static NSString * const kPKProviderCapabilityMeetings = @"meetings";

#pragma mark - Files
static NSString * const kPKFileHostedByPodio = @"podio";

#pragma mark - Batch
static NSString * const kPKBatchPluginAppImport = @"app_import";
static NSString * const kPKBatchPluginAppExport = @"app_export";
static NSString * const kPKBatchPluginAppConnectionLoad = @"connection_load";

#pragma mark - Promotions

typedef enum {
  PKPromotionContextNone,
  PKPromotionContextGlobalHome,
  PKPromotionContextSpaceHome,
  PKPromotionContextEmployeeNetworkHome,
  PKPromotionContextDemoHome,
  PKPromotionContextTasks,
  PKPromotionContextContacts,
  PKPromotionContextCalendar,
  PKPromotionContextConversations,
  PKPromotionContextCreateItem,
  PKPromotionContextEditItem,
  PKPromotionContextAppView,
  PKPromotionContextTaskModal,
  PKPromotionContextConversationModal,
  PKPromotionContextInvitationModal,
  PKPromotionContextNotifications,
  PKPromotionContextiOSGlobalStream,
} PKPromotionContext;

static NSString * const kPKPromotionContextGlobalHome = @"global_home";
static NSString * const kPKPromotionContextSpaceHome = @"space_home";
static NSString * const kPKPromotionContextEmployeeNetworkHome = @"emp_network_home";
static NSString * const kPKPromotionContextDemoHome = @"demo_home";
static NSString * const kPKPromotionContextTasks = @"tasks";
static NSString * const kPKPromotionContextContacts = @"contacts";
static NSString * const kPKPromotionContextCalendar = @"calendar";
static NSString * const kPKPromotionContextConversations = @"conversations";
static NSString * const kPKPromotionContextCreateItem = @"create_item";
static NSString * const kPKPromotionContextEditItem = @"edit_item";
static NSString * const kPKPromotionContextAppView = @"app_view";
static NSString * const kPKPromotionContextTaskModal = @"task_modal";
static NSString * const kPKPromotionContextConversationModal = @"conversation_modal";
static NSString * const kPKPromotionContextInvitationModal = @"invitation_modal";
static NSString * const kPKPromotionContextNotifications = @"notifications";
static NSString * const kPKPromotionContextiOSGlobalStream = @"ios_global_stream";

typedef enum {
  PKPromotionDisplayTypeNone,
  PKPromotionDisplayTypeBaloon,
  PKPromotionDisplayTypeBanner,
  PKPromotionDisplayTypeFeatureTour,
  PKPromotionDisplayTypeNetPromoterScore,
  PKPromotionDisplayTypeOlarkChat,
  PKPromotionDisplayTypeiOSBanner,
  PKPromotionDisplayTypeiOSNetPromoterScore,
} PKPromotionDisplayType;

static NSString * const kPKPromotionDisplayTypeBaloon = @"baloon";
static NSString * const kPKPromotionDisplayTypeBanner = @"banner";
static NSString * const kPKPromotionDisplayTypeFeatureTour = @"feature_tour";
static NSString * const kPKPromotionDisplayTypeNetPromoterScore = @"net_promoter_score";
static NSString * const kPKPromotionDisplayTypeOlarkChat = @"olark_chat";
static NSString * const kPKPromotionDisplayTypeiOSBanner = @"ios_banner";
static NSString * const kPKPromotionDisplayTypeiOSNetPromoterScore = @"ios_net_promoter_score";

#pragma mark - Phone types
typedef NS_ENUM(NSUInteger, PKPhoneType) {
  PKPhoneTypeMobile = 0,
  PKPhoneTypeWork,
  PKPhoneTypeHome,
  PKPhoneTypeMain,
  PKPhoneTypeWorkFax,
  PKPhoneTypePrivateFax,
  PKPhoneTypeOther,
};

#pragma mark - Email types
typedef NS_ENUM(NSUInteger, PKEmailType) {
  PKEmailTypeOther = 0,
  PKEmailTypeHome,
  PKEmailTypeWork,
};

#pragma mark - Avatars

typedef enum {
  PKAvatarTypeNone = 0,
  PKAvatarTypeFile,
  PKAvatarTypeIcon,
} PKAvatarType;

static NSString * const kPKAvatarTypeFile = @"file";
static NSString * const kPKAvatarTypeIcon = @"icon";

typedef enum {
  PKAvatarSizeNone = 0,
  PKAvatarSizeDefault,
  PKAvatarSizeTiny,
  PKAvatarSizeSmall,
  PKAvatarSizeMedium,
  PKAvatarSizeLarge,
} PKAvatarSize;

static NSString * const kPKAvatarSizeDefault = @"default"; // 40x40
static NSString * const kPKAvatarSizeTiny = @"tiny";       // 16x16
static NSString * const kPKAvatarSizeSmall = @"small";     // 32x32
static NSString * const kPKAvatarSizeMedium = @"medium";   // 80x80
static NSString * const kPKAvatarSizeLarge = @"large";     // 160x160

typedef enum {
  PKImageSizeNone = 0,
  PKImageSizeDefault,
  PKImageSizeTiny,
  PKImageSizeSmall,
  PKImageSizeMedium,
  PKImageSizeBadge,
  PKImageSizeLarge,
  PKImageSizeExtraLarge,
  PKImageSizeIOSLarge,
} PKImageSize;

static NSString * const kPKImageSizeDefault = @"default"; // 40x40
static NSString * const kPKImageSizeTiny = @"tiny"; // 16x16
static NSString * const kPKImageSizeSmall = @"small"; // 32x32
static NSString * const kPKImageSizeMedium = @"medium"; // 80x80
static NSString * const kPKImageSizeBadge = @"badge"; // 220x160
static NSString * const kPKImageSizeLarge = @"large"; // 160x160
static NSString * const kPKImageSizeExtraLarge = @"extra_large"; // 520x?
static NSString * const kPKImageSizeIOSLarge = @"ios_large"; // 200x200

@interface PKConstants : NSObject

// Tasks
+ (PKTaskStatus)taskStatusForString:(NSString *)string;
+ (PKTaskActionType)taskActionTypeForString:(NSString *)string;
+ (PKTaskGroup)taskGroupForString:(NSString *)string;

// App
+ (PKAppType)appTypeForString:(NSString *)string;
+ (PKAppFieldMapping)appFieldMappingForString:(NSString *)string;

// Conversation
+ (PKConversationType)conversationTypeForString:(NSString *)string;
+ (PKConversationEventAction)conversationEventActionForString:(NSString *)string;

// Stream
+ (PKStreamActivityType)streamActivityTypeForString:(NSString *)string;

// Action
+ (PKActionType)actionTypeForString:(NSString *)string;

// Vote
+ (PKVoteType)voteTypeForString:(NSString *)string;

// Rating
+ (PKRatingType)ratingTypeForString:(NSString *)string;

// Rights
+ (NSUInteger)rightsMaskFromArrayOfStrings:(NSArray *)strings;

// Roles
+ (PKRole)roleForString:(NSString *)string;
+ (NSString *)stringForRole:(PKRole)role;

// Reference
+ (PKReferenceType)referenceTypeForString:(NSString *)string;
+ (NSString *)stringForReferenceType:(PKReferenceType)referenceType;

// Grant
+ (PKGrantAction)grantActionForString:(NSString *)string;
+ (NSString *)stringForGrantAction:(PKGrantAction)grantAction;

// Space
+ (PKSpaceType)spaceTypeForString:(NSString *)string;
+ (PKSpaceCreateStatus)spaceCreateStatusForString:(NSString *)string;
+ (PKSpaceMemberRequestStatus)spaceMemberRequestStatusForString:(NSString *)string;

// Avatar
+ (PKAvatarType)avatarTypeForString:(NSString *)string;

// Notification
+ (PKNotificationType)notificationTypeForString:(NSString *)string;

// Meetings
+ (PKExternalMeetingType)externalMeetingTypeForString:(NSString *)string;
+ (PKMeetingParticipantStatus)meetingParticipantStatusForString:(NSString *)string;
+ (NSString *)stringForMeetingParticipantStatus:(PKMeetingParticipantStatus)status;

// Providers
+ (PKProviderCapability)providerCapabilityForString:(NSString *)string;
+ (NSString *)stringForProviderCapability:(PKProviderCapability)capability;

// App
+ (PKAppFieldType)appFieldTypeForString:(NSString *)string;
+ (NSString *)stringForAppFieldType:(PKAppFieldType)type;
+ (PKAppFieldStatus)appFieldStatusForString:(NSString *)string;
+ (NSString *)stringForAppFieldStatus:(PKAppFieldStatus)status;

// Promotions
+ (NSString *)stringForPromotionContext:(PKPromotionContext)context;
+ (PKPromotionContext)promotionContextForString:(NSString *)string;
+ (PKPromotionDisplayType)promotionDisplayTypeForString:(NSString *)string;

// Images
+ (NSString *)stringForImageSize:(PKImageSize)imageSize isRetina:(BOOL)isRetina;

@end
