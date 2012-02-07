//
//  PKConstants.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/28/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - Errors/Exceptions

static NSString * const kPodioKitErrorDomain = @"PodioKitErrorDomain";

typedef enum {
  PKErrorCodeNoConnection = 1001,
  PKErrorCodeParsingFailed = 1002,
  PKErrorCodeMultipleRequests = 1003,
  PKErrorCodeRequestCancelled = 1004,
  PKErrorCodeServerError = 2000,
} PKErrorCode;

#pragma mark - Contact

static NSString* const kPKContactTypeContact = @"space";
static NSString* const kPKContactTypeUser = @"user";
static NSString* const kPKContactTypeConnection = @"connection";

static NSString * const kPKUserTypeUser = @"user";
static NSString * const kPKUserTypeApp = @"app";

typedef enum {
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
} PKRight;

typedef enum {
  PKSpaceTypeNone = 0,
  PKSpaceTypeRegular,
  PKSpaceTypeEmployeeNetwork,
} PKSpaceType;

static NSString * const kPKSpaceTypeRegular = @"regular";
static NSString * const kPKSpaceTypeEmployeeNetwork = @"emp_network";

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

#pragma mark - Item

// Field types
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


#pragma mark - Stream

typedef enum {
  PKStreamActivityTypeNone = 0,
  PKStreamActivityTypeComment,
  PKStreamActivityTypeFile,
  PKStreamActivityTypeRating,
  PKStreamActivityTypeCreation,
  PKStreamActivityTypeUpdate,
  PKStreamActivityTypeTask,
  PKStreamActivityTypeAnswer,
} PKStreamActivityType;

static NSString * const kPKStreamActivityTypeComment = @"comment";
static NSString * const kPKStreamActivityTypeFile = @"file";
static NSString * const kPKStreamActivityTypeRating = @"rating";
static NSString * const kPKStreamActivityTypeCreation = @"creation";
static NSString * const kPKStreamActivityTypeUpdate = @"update";
static NSString * const kPKStreamActivityTypeTask = @"task";
static NSString * const kPKStreamActivityTypeAnswer = @"answer";

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

#pragma mark - Rating

typedef enum {
  PKRatingTypeNone = 0,
  PKRatingTypeApproved,
  PKRatingTypeRSVP,
  PKRatingTypeFivestar,
  PKRatingTypeYesNo,
  PKRatingTypeThumbs,
  PKRatingTypeLike,
} PKRatingType;

static NSString * const kPKRatingTypeApproved = @"approved";
static NSString * const kPKRatingTypeRSVP = @"rsvp";
static NSString * const kPKRatingTypeFivestar = @"fivestar";
static NSString * const kPKRatingTypeYesNo = @"yesno";
static NSString * const kPKRatingTypeThumbs = @"thumbs";
static NSString * const kPKRatingTypeLike = @"like";

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
//static NSString * const kPKReferenceTypeInvoice = @"invoice";
//static NSString * const kPKReferenceTypePayment = @"payment";
static NSString * const kPKReferenceTypeMeeting = @"meeting";

// Notifications
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

// Avatars
typedef enum {
  PKAvatarTypeNone = 0,
  PKAvatarTypeFile,
  PKAvatarTypeIcon,
} PKAvatarType;

static NSString * const kPKAvatarTypeFile = @"file";
static NSString * const kPKAvatarTypeIcon = @"icon";

static NSString * const kPKAvatarSizeTiny = @"tiny";      // 16x16
static NSString * const kPKAvatarSizeSmall = @"small";    // 32x32
static NSString * const kPKAvatarSizeMedium = @"medium";  // 80x80
static NSString * const kPKAvatarSizeLarge = @"large";    // 160x160

static NSString * const kPKImageSizeMedium = @"medium"; // 80x80
static NSString * const kPKImageSizeBadge = @"badge"; // 220x160
static NSString * const kPKImageSizeExtraLarge = @"extra_large"; // 520x?

@interface PKConstants : NSObject

// Tasks
+ (PKTaskStatus)taskStatusForString:(NSString *)string;
+ (PKTaskActionType)taskActionTypeForString:(NSString *)string;
+ (PKTaskGroup)taskGroupForString:(NSString *)string;

// Stream
+ (PKReferenceType)streamObjectTypeForString:(NSString *)string;
+ (PKStreamActivityType)streamActivityTypeForString:(NSString *)string;

// Action
+ (PKActionType)actionTypeForString:(NSString *)string;

// Rating
+ (PKRatingType)ratingTypeForString:(NSString *)string;

// Rights
+ (NSUInteger)rightsMaskFromArrayOfStrings:(NSArray *)strings;

// Reference
+ (PKReferenceType)referenceTypeForString:(NSString *)string;
+ (NSString *)stringForReferenceType:(PKReferenceType)referenceType;

// Space
+ (PKSpaceType)spaceTypeForString:(NSString *)string;

// Avatar
+ (PKAvatarType)avatarTypeForString:(NSString *)string;

// Notification
+ (PKNotificationType)notificationTypeForString:(NSString *)string;

@end
