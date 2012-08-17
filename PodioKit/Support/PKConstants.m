//
//  PKConstants.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/28/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKConstants.h"


@implementation PKConstants

// Tasks
+ (PKTaskStatus)taskStatusForString:(NSString *)string {
  PKTaskStatus status = PKTaskStatusNone;
  
  if ([string isEqualToString:kPKTaskStatusActive]) {
    status = PKTaskStatusActive;
  } else if ([string isEqualToString:kPKTaskStatusCompleted]) {
    status = PKTaskStatusCompleted;
  } else if ([string isEqualToString:kPKTaskStatusDeleted]) {
    status = PKTaskStatusDeleted;
  }
  
  return status;
}

+ (PKTaskActionType)taskActionTypeForString:(NSString *)string {
  PKTaskActionType type = PKTaskActionTypeNone;
  
  if ([string isEqualToString:kPKTaskActionTypeCreation]) {
    type = PKTaskActionTypeCreation;
  } else if ([string isEqualToString:kPKTaskActionTypeStart]) {
    type = PKTaskActionTypeStart;
  } else if ([string isEqualToString:kPKTaskActionTypeStop]) {
    type = PKTaskActionTypeStop;
  } else if ([string isEqualToString:kPKTaskActionTypeAssign]) {
    type = PKTaskActionTypeAssign;
  } else if ([string isEqualToString:kPKTaskActionTypeComplete]) {
    type = PKTaskActionTypeComplete;
  } else if ([string isEqualToString:kPKTaskActionTypeIncomplete]) {
    type = PKTaskActionTypeIncomplete;
  } else if ([string isEqualToString:kPKTaskActionTypeUpdateText]) {
    type = PKTaskActionTypeUpdateText;
  } else if ([string isEqualToString:kPKTaskActionTypeUpdateDescription]) {
    type = PKTaskActionTypeUpdateDescription;
  } else if ([string isEqualToString:kPKTaskActionTypeUpdateDueDate]) {
    type = PKTaskActionTypeUpdateDueDate;
  } else if ([string isEqualToString:kPKTaskActionTypeUpdatePrivate]) {
    type = PKTaskActionTypeUpdatePrivate;
  } else if ([string isEqualToString:kPKTaskActionTypeDelete]) {
    type = PKTaskActionTypeDelete;
  } else if ([string isEqualToString:kPKTaskActionTypeUpdateRef]) {
    type = PKTaskActionTypeUpdateRef;
  }
  
  return type;
}

+ (PKTaskGroup)taskGroupForString:(NSString *)string {
  PKTaskGroup group = PKTaskGroupNone;
  
  if ([string isEqualToString:kPKTaskGroupOverdue]) {
    group = PKTaskGroupOverdue;
  } else if ([string isEqualToString:kPKTaskGroupToday]) {
    group = PKTaskGroupToday;
  } else if ([string isEqualToString:kPKTaskGroupTomorrow]) {
    group = PKTaskGroupTomorrow;
  } else if ([string isEqualToString:kPKTaskGroupUpcoming]) {
    group = PKTaskGroupUpcoming;
  } else if ([string isEqualToString:kPKTaskGroupLater]) {
    group = PKTaskGroupLater;
  } else if ([string isEqualToString:kPKTaskGroup1Day]) {
    group = PKTaskGroup1Day;
  } else if ([string isEqualToString:kPKTaskGroup2Day]) {
    group = PKTaskGroup2Day;
  } else if ([string isEqualToString:kPKTaskGroup3Day]) {
    group = PKTaskGroup3Day;
  } else if ([string isEqualToString:kPKTaskGroup4Day]) {
    group = PKTaskGroup4Day;
  } else if ([string isEqualToString:kPKTaskGroup5Day]) {
    group = PKTaskGroup5Day;
  } else if ([string isEqualToString:kPKTaskGroup6Day]) {
    group = PKTaskGroup6Day;
  } else if ([string isEqualToString:kPKTaskGroup1Week]) {
    group = PKTaskGroup1Week;
  } else if ([string isEqualToString:kPKTaskGroup2Week]) {
    group = PKTaskGroup2Week;
  } else if ([string isEqualToString:kPKTaskGroup3Week]) {
    group = PKTaskGroup3Week;
  } else if ([string isEqualToString:kPKTaskGroup4Week]) {
    group = PKTaskGroup4Week;
  } else if ([string isEqualToString:kPKTaskGroup1Month]) {
    group = PKTaskGroup1Month;
  } else if ([string isEqualToString:kPKTaskGroup2Month]) {
    group = PKTaskGroup2Month;
  } else if ([string isEqualToString:kPKTaskGroup3Month]) {
    group = PKTaskGroup3Month;
  } else if ([string isEqualToString:kPKTaskGroup4Month]) {
    group = PKTaskGroup4Month;
  } else if ([string isEqualToString:kPKTaskGroup5Month]) {
    group = PKTaskGroup5Month;
  } else if ([string isEqualToString:kPKTaskGroup6Month]) {
    group = PKTaskGroup6Month;
  } else if ([string isEqualToString:kPKTaskGroup7Month]) {
    group = PKTaskGroup7Month;
  } else if ([string isEqualToString:kPKTaskGroup8Month]) {
    group = PKTaskGroup8Month;
  } else if ([string isEqualToString:kPKTaskGroup9Month]) {
    group = PKTaskGroup9Month;
  } else if ([string isEqualToString:kPKTaskGroup10Month]) {
    group = PKTaskGroup10Month;
  } else if ([string isEqualToString:kPKTaskGroup11Month]) {
    group = PKTaskGroup11Month;
  } else if ([string isEqualToString:kPKTaskGroup12Month]) {
    group = PKTaskGroup12Month;
  } else if ([string isEqualToString:kPKTaskGroup1Year]) {
    group = PKTaskGroup1Year;
  } else if ([string isEqualToString:kPKTaskGroupOlder]) {
    group = PKTaskGroupOlder;
  }
  
  return group;
}

// App
+ (PKAppType)appTypeForString:(NSString *)string {
  PKAppType type = PKAppTypeNone;
  
  if ([string isEqualToString:kPKAppTypeStandard]) {
    type = PKAppTypeStandard;
  } else if ([string isEqualToString:kPKAppTypeMeeting]) {
    type = PKAppTypeMeeting;
  }
  
  return type;
}

+ (PKAppFieldMapping)appFieldMappingForString:(NSString *)string {
  PKAppFieldMapping mapping = PKAppFieldMappingNone;
  
  if ([string isEqualToString:kPKAppFieldMappingMeetingTime]) {
    mapping = PKAppFieldMappingMeetingTime;
  } else if ([string isEqualToString:kPKAppFieldMappingMeetingParticipants]) {
    mapping = PKAppFieldMappingMeetingParticipants;
  } else if ([string isEqualToString:kPKAppFieldMappingMeetingAgenda]) {
    mapping = PKAppFieldMappingMeetingAgenda;
  } else if ([string isEqualToString:kPKAppFieldMappingMeetingLocation]) {
    mapping = PKAppFieldMappingMeetingLocation;
  }
  
  return mapping;
}

// Stream
+ (PKStreamActivityType)streamActivityTypeForString:(NSString *)string {
  PKStreamActivityType type = PKStreamActivityTypeNone;

  if ([string isEqualToString:kPKStreamActivityTypeComment]) {
    type = PKStreamActivityTypeComment;
  } else if ([string isEqualToString:kPKStreamActivityTypeFile]) {
    type = PKStreamActivityTypeFile;
  } else if ([string isEqualToString:kPKStreamActivityTypeRating]) {
    type = PKStreamActivityTypeRating;
  } else if ([string isEqualToString:kPKStreamActivityTypeCreation]) {
    type = PKStreamActivityTypeCreation;
  } else if ([string isEqualToString:kPKStreamActivityTypeUpdate]) {
    type = PKStreamActivityTypeUpdate;
  } else if ([string isEqualToString:kPKStreamActivityTypeTask]) {
    type = PKStreamActivityTypeTask;
  } else if ([string isEqualToString:kPKStreamActivityTypeAnswer]) {
    type = PKStreamActivityTypeAnswer;
  }
  
  return type;
}

// Action
+ (PKActionType)actionTypeForString:(NSString *)string {
  PKActionType type = PKActionTypeNone;
  
  if ([string isEqualToString:kPKActionTypeSpaceCreated]) {
    type = PKActionTypeSpaceCreated;
  } else if ([string isEqualToString:kPKActionTypeMemberAdded]) {
    type = PKActionTypeMemberAdded;
  } else if ([string isEqualToString:kPKActionTypeMemberLeft]) {
    type = PKActionTypeMemberLeft;
  } else if ([string isEqualToString:kPKActionTypeMemberKicked]) {
    type = PKActionTypeMemberKicked;
  } else if ([string isEqualToString:kPKActionTypeAppCreated]) {
    type = PKActionTypeAppCreated;
  } else if ([string isEqualToString:kPKActionTypeAppInstalled]) {
    type = PKActionTypeAppInstalled;
  } else if ([string isEqualToString:kPKActionTypeAppUpdated]) {
    type = PKActionTypeAppUpdated;
  } else if ([string isEqualToString:kPKActionTypeAppDeactivated]) {
    type = PKActionTypeAppDeactivated;
  } else if ([string isEqualToString:kPKActionTypeAppActivated]) {
    type = PKActionTypeAppActivated;
  } else if ([string isEqualToString:kPKActionTypeAppDeleted]) {
    type = PKActionTypeAppDeleted;
  } else if ([string isEqualToString:kPKActionTypeMemberJoined]) {
    type = PKActionTypeMemberJoined;
  }
  
  return type;
}

// Rating
+ (PKRatingType)ratingTypeForString:(NSString *)string {
  PKRatingType type = PKRatingTypeNone;
  
  if ([string isEqualToString:kPKRatingTypeLike]) {
    type = PKRatingTypeLike;
  } else if ([string isEqualToString:kPKRatingTypeApproved]) {
    type = PKRatingTypeApproved;
  } else if ([string isEqualToString:kPKRatingTypeRSVP]) {
    type = PKRatingTypeRSVP;
  } else if ([string isEqualToString:kPKRatingTypeFivestar]) {
    type = PKRatingTypeFivestar;
  } else if ([string isEqualToString:kPKRatingTypeYesNo]) {
    type = PKRatingTypeYesNo;
  } else if ([string isEqualToString:kPKRatingTypeThumbs]) {
    type = PKRatingTypeThumbs;
  }
  
  return type;
}

// Rights
+ (NSUInteger)rightsMaskFromArrayOfStrings:(NSArray *)strings {
  __block NSUInteger rightsMask = 0;
  
  [strings enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
    if ([obj isEqualToString:@"view"]) {
      rightsMask |= PKRightView;
    } else if ([obj isEqualToString:@"update"]) {
      rightsMask |= PKRightUpdate;
    } else if ([obj isEqualToString:@"delete"]) {
      rightsMask |= PKRightDelete;
    } else if ([obj isEqualToString:@"subscribe"]) {
      rightsMask |= PKRightSubscribe;
    } else if ([obj isEqualToString:@"comment"]) {
      rightsMask |= PKRightComment;
    } else if ([obj isEqualToString:@"rate"]) {
      rightsMask |= PKRightRate;
    } else if ([obj isEqualToString:@"share"]) {
      rightsMask |= PKRightShare;
    } else if ([obj isEqualToString:@"install"]) {
      rightsMask |= PKRightInstall;
    } else if ([obj isEqualToString:@"add_app"]) {
      rightsMask |= PKRightAddApp;
    } else if ([obj isEqualToString:@"add_item"]) {
      rightsMask |= PKRightAddItem;
    } else if ([obj isEqualToString:@"add_file"]) {
      rightsMask |= PKRightAddFile;
    } else if ([obj isEqualToString:@"add_task"]) {
      rightsMask |= PKRightAddTask;
    } else if ([obj isEqualToString:@"add_space"]) {
      rightsMask |= PKRightAddSpace;
    } else if ([obj isEqualToString:@"add_status"]) {
      rightsMask |= PKRightAddStatus;
    } else if ([obj isEqualToString:@"add_conversation"]) {
      rightsMask |= PKRightAddConversation;
    } else if ([obj isEqualToString:@"reply"]) {
      rightsMask |= PKRightReply;
    } else if ([obj isEqualToString:@"add_filter"]) {
      rightsMask |= PKRightAddFilter;
    } else if ([obj isEqualToString:@"add_widget"]) {
      rightsMask |= PKRightAddWidget;
    } else if ([obj isEqualToString:@"statistics"]) {
      rightsMask |= PKRightStatistics;
    } else if ([obj isEqualToString:@"add_contact"]) {
      rightsMask |= PKRightAddContact;
    } else if ([obj isEqualToString:@"add_hook"]) {
      rightsMask |= PKRightAddHook;
    } else if ([obj isEqualToString:@"add_question"]) {
      rightsMask |= PKRightAddQuestion;
    } else if ([obj isEqualToString:@"add_answer"]) {
      rightsMask |= PKRightAddAnswer;
    }
  }];
  
  return rightsMask;
}

+ (PKReferenceType)referenceTypeForString:(NSString *)string {
  PKReferenceType type = PKReferenceTypeNone;
  
  if ([string isEqualToString:kPKReferenceTypeApp]) {
    type = PKReferenceTypeApp;
  } else if ([string isEqualToString:kPKReferenceTypeAppRevision]) {
    type = PKReferenceTypeAppRevision;
  } else if ([string isEqualToString:kPKReferenceTypeAppField]) {
    type = PKReferenceTypeAppField;
  } else if ([string isEqualToString:kPKReferenceTypeItem]) {
    type = PKReferenceTypeItem;
  } else if ([string isEqualToString:kPKReferenceTypeBulletin]) {
    type = PKReferenceTypeBulletin;
  } else if ([string isEqualToString:kPKReferenceTypeComment]) {
    type = PKReferenceTypeComment;
  } else if ([string isEqualToString:kPKReferenceTypeStatus]) {
    type = PKReferenceTypeStatus;
  } else if ([string isEqualToString:kPKReferenceTypeSpaceMember]) {
    type = PKReferenceTypeSpaceMember;
  } else if ([string isEqualToString:kPKReferenceTypeAlert]) {
    type = PKReferenceTypeAlert;
  } else if ([string isEqualToString:kPKReferenceTypeItemRevision]) {
    type = PKReferenceTypeItemRevision;
  } else if ([string isEqualToString:kPKReferenceTypeRating]) {
    type = PKReferenceTypeRating;
  } else if ([string isEqualToString:kPKReferenceTypeTask]) {
    type = PKReferenceTypeTask;
  } else if ([string isEqualToString:kPKReferenceTypeTaskAction]) {
    type = PKReferenceTypeTaskAction;
  } else if ([string isEqualToString:kPKReferenceTypeSpace]) {
    type = PKReferenceTypeSpace;
  } else if ([string isEqualToString:kPKReferenceTypeOrg]) {
    type = PKReferenceTypeOrg;
  } else if ([string isEqualToString:kPKReferenceTypeConversation]) {
    type = PKReferenceTypeConversation;
  } else if ([string isEqualToString:kPKReferenceTypeNotification]) {
    type = PKReferenceTypeNotification;
  } else if ([string isEqualToString:kPKReferenceTypeFile]) {
    type = PKReferenceTypeFile;
  } else if ([string isEqualToString:kPKReferenceTypeFileService]) {
    type = PKReferenceTypeFileService;
  } else if ([string isEqualToString:kPKReferenceTypeProfile]) {
    type = PKReferenceTypeProfile;
  } else if ([string isEqualToString:kPKReferenceTypeUser]) {
    type = PKReferenceTypeUser;
  } else if ([string isEqualToString:kPKReferenceTypeWidget]) {
    type = PKReferenceTypeWidget;
  } else if ([string isEqualToString:kPKReferenceTypeShare]) {
    type = PKReferenceTypeShare;
  } else if ([string isEqualToString:kPKReferenceTypeForm]) {
    type = PKReferenceTypeForm;
  } else if ([string isEqualToString:kPKReferenceTypeAuthClient]) {
    type = PKReferenceTypeAuthClient;
  } else if ([string isEqualToString:kPKReferenceTypeConnection]) {
    type = PKReferenceTypeConnection;
  } else if ([string isEqualToString:kPKReferenceTypeIntegration]) {
    type = PKReferenceTypeIntegration;
  } else if ([string isEqualToString:kPKReferenceTypeShareInstall]) {
    type = PKReferenceTypeShareInstall;
  } else if ([string isEqualToString:kPKReferenceTypeIcon]) {
    type = PKReferenceTypeIcon;
  } else if ([string isEqualToString:kPKReferenceTypeOrgMember]) {
    type = PKReferenceTypeOrgMember;
  } else if ([string isEqualToString:kPKReferenceTypeNews]) {
    type = PKReferenceTypeNews;
  } else if ([string isEqualToString:kPKReferenceTypeHook]) {
    type = PKReferenceTypeHook;
  } else if ([string isEqualToString:kPKReferenceTypeTag]) {
    type = PKReferenceTypeTag;
  } else if ([string isEqualToString:kPKReferenceTypeEmbed]) {
    type = PKReferenceTypeEmbed;
  } else if ([string isEqualToString:kPKReferenceTypeQuestion]) {
    type = PKReferenceTypeQuestion;
  } else if ([string isEqualToString:kPKReferenceTypeQuestionAnswer]) {
    type = PKReferenceTypeQuestionAnswer;
  } else if ([string isEqualToString:kPKReferenceTypeAction]) {
    type = PKReferenceTypeAction;
  } else if ([string isEqualToString:kPKReferenceTypeContract]) {
    type = PKReferenceTypeContract;
  } else if ([string isEqualToString:kPKReferenceTypeMeeting]) {
    type = PKReferenceTypeMeeting;
  } else if ([string isEqualToString:kPKReferenceTypeBatch]) {
    type = PKReferenceTypeBatch;
  } else if ([string isEqualToString:kPKReferenceTypeSystem]) {
    type = PKReferenceTypeSystem;
  } else if ([string isEqualToString:kPKReferenceTypeSpaceMemberRequest]) {
    type = PKReferenceTypeSpaceMemberRequest;
  }
    
  return type;
}

+ (NSString *)stringForReferenceType:(PKReferenceType)referenceType {
  NSString *string = nil;
  
  switch (referenceType) {
    case PKReferenceTypeApp:
      string = kPKReferenceTypeApp;
      break;
    case PKReferenceTypeAppRevision:
      string = kPKReferenceTypeAppRevision;
      break;
    case PKReferenceTypeAppField:
      string = kPKReferenceTypeAppField;
      break;
    case PKReferenceTypeItem:
      string = kPKReferenceTypeItem;
      break;
    case PKReferenceTypeBulletin:
      string = kPKReferenceTypeBulletin;
      break;
    case PKReferenceTypeComment:
      string = kPKReferenceTypeComment;
      break;
    case PKReferenceTypeStatus:
      string = kPKReferenceTypeStatus;
      break;
    case PKReferenceTypeSpaceMember:
      string = kPKReferenceTypeSpaceMember;
      break;
    case PKReferenceTypeAlert:
      string = kPKReferenceTypeAlert;
      break;
    case PKReferenceTypeItemRevision:
      string = kPKReferenceTypeItemRevision;
      break;
    case PKReferenceTypeRating:
      string = kPKReferenceTypeRating;
      break;
    case PKReferenceTypeTask:
      string = kPKReferenceTypeTask;
      break;
    case PKReferenceTypeTaskAction:
      string = kPKReferenceTypeTaskAction;
      break;
    case PKReferenceTypeSpace:
      string = kPKReferenceTypeSpace;
      break;
    case PKReferenceTypeOrg:
      string = kPKReferenceTypeOrg;
      break;
    case PKReferenceTypeConversation:
      string = kPKReferenceTypeConversation;
      break;
    case PKReferenceTypeNotification:
      string = kPKReferenceTypeNotification;
      break;
    case PKReferenceTypeFile:
      string = kPKReferenceTypeFile;
      break;
    case PKReferenceTypeFileService:
      string = kPKReferenceTypeFileService;
      break;
    case PKReferenceTypeProfile:
      string = kPKReferenceTypeProfile;
      break;
    case PKReferenceTypeUser:
      string = kPKReferenceTypeUser;
      break;
    case PKReferenceTypeWidget:
      string = kPKReferenceTypeWidget;
      break;
    case PKReferenceTypeShare:
      string = kPKReferenceTypeShare;
      break;
    case PKReferenceTypeForm:
      string = kPKReferenceTypeForm;
      break;
    case PKReferenceTypeAuthClient:
      string = kPKReferenceTypeAuthClient;
      break;
    case PKReferenceTypeConnection:
      string = kPKReferenceTypeConnection;
      break;
    case PKReferenceTypeIntegration:
      string = kPKReferenceTypeIntegration;
      break;
    case PKReferenceTypeShareInstall:
      string = kPKReferenceTypeShareInstall;
      break;
    case PKReferenceTypeIcon:
      string = kPKReferenceTypeIcon;
      break;
    case PKReferenceTypeOrgMember:
      string = kPKReferenceTypeOrgMember;
      break;
    case PKReferenceTypeNews:
      string = kPKReferenceTypeNews;
      break;
    case PKReferenceTypeHook:
      string = kPKReferenceTypeHook;
      break;
    case PKReferenceTypeTag:
      string = kPKReferenceTypeTag;
      break;
    case PKReferenceTypeEmbed:
      string = kPKReferenceTypeEmbed;
      break;
    case PKReferenceTypeQuestion:
      string = kPKReferenceTypeQuestion;
      break;
    case PKReferenceTypeQuestionAnswer:
      string = kPKReferenceTypeQuestionAnswer;
      break;
    case PKReferenceTypeAction:
      string = kPKReferenceTypeAction;
      break;
    case PKReferenceTypeContract:
      string = kPKReferenceTypeContract;
      break;
    case PKReferenceTypeMeeting:
      string = kPKReferenceTypeMeeting;
      break;
    default:
      break;
  }
  
  return string;
}

#pragma mark - Space

+ (PKSpaceType)spaceTypeForString:(NSString *)string {
  PKSpaceType type = PKSpaceTypeNone;
  
  if ([string isEqualToString:kPKSpaceTypeRegular]) {
    type = PKSpaceTypeRegular;
  } else if ([string isEqualToString:kPKSpaceTypeEmployeeNetwork]) {
    type = PKSpaceTypeEmployeeNetwork;
  }
  
  return type;
}

+ (PKSpaceCreateStatus)spaceCreateStatusForString:(NSString *)string {
  PKSpaceCreateStatus type = PKSpaceCreateStatusNone;
  
  if ([string isEqualToString:kPKSpaceCreateStatusJoined]) {
    type = PKSpaceCreateStatusJoined;
  } else if ([string isEqualToString:kPKSpaceCreateStatusOpen]) {
    type = PKSpaceCreateStatusOpen;
  } else if ([string isEqualToString:kPKSpaceCreateStatusClosed]) {
    type = PKSpaceCreateStatusClosed;
  } else if ([string isEqualToString:kPKSpaceCreateStatusDeleted]) {
    type = PKSpaceCreateStatusDeleted;
  }
  
  return type;
}

+ (PKSpaceMemberRequestStatus)spaceMemberRequestStatusForString:(NSString *)string {
  PKSpaceMemberRequestStatus status = PKSpaceMemberRequestStatusNone;
  
  if ([string isEqualToString:kPKSpaceMemberRequestStatusActive]) {
    status = PKSpaceMemberRequestStatusActive;
  } else if ([string isEqualToString:kPKSpaceMemberRequestStatusAccepted]) {
    status = PKSpaceMemberRequestStatusAccepted;
  }
  
  return status;
}

#pragma mark - Avatar

+ (PKAvatarType)avatarTypeForString:(NSString *)string {
  PKAvatarType type = PKAvatarTypeNone;
  
  if ([string isEqualToString:kPKAvatarTypeFile]) {
    type = PKAvatarTypeFile;
  } else if ([string isEqualToString:kPKAvatarTypeIcon]) {
    type = PKAvatarTypeIcon;
  }
  
  return type;
}

#pragma mark - Notifications

+ (PKNotificationType)notificationTypeForString:(NSString *)string {
  PKNotificationType type = PKNotificationTypeNone;
  
  if ([string isEqualToString:kPKNotificationTypeAlert]) {
    type = PKNotificationTypeAlert;
  } else if ([string isEqualToString:kPKNotificationTypeCreation]) {
    type = PKNotificationTypeCreation;
  } else if ([string isEqualToString:kPKNotificationTypeUpdate]) {
    type = PKNotificationTypeUpdate;
  } else if ([string isEqualToString:kPKNotificationTypeDelete]) {
    type = PKNotificationTypeDelete;
  } else if ([string isEqualToString:kPKNotificationTypeComment]) {
    type = PKNotificationTypeComment;
  } else if ([string isEqualToString:kPKNotificationTypeRating]) {
    type = PKNotificationTypeRating;
  } else if ([string isEqualToString:kPKNotificationTypeMessage]) {
    type = PKNotificationTypeMessage;
  } else if ([string isEqualToString:kPKNotificationTypeSpaceInvite]) {
    type = PKNotificationTypeSpaceInvite;
  } else if ([string isEqualToString:kPKNotificationTypeBulletin]) {
    type = PKNotificationTypeBulletin;
  } else if ([string isEqualToString:kPKNotificationTypeMemberReferenceAdd]) {
    type = PKNotificationTypeMemberReferenceAdd;
  } else if ([string isEqualToString:kPKNotificationTypeMemberReferenceRemove]) {
    type = PKNotificationTypeMemberReferenceRemove;
  } else if ([string isEqualToString:kPKNotificationTypeFile]) {
    type = PKNotificationTypeFile;
  } else if ([string isEqualToString:kPKNotificationTypeUserLeftSpace]) {
    type = PKNotificationTypeUserLeftSpace;
  } else if ([string isEqualToString:kPKNotificationTypeUserKickedFromSpace]) {
    type = PKNotificationTypeUserKickedFromSpace;
  } else if ([string isEqualToString:kPKNotificationTypeRoleChange]) {
    type = PKNotificationTypeRoleChange;
  } else if ([string isEqualToString:kPKNotificationTypeRSVP]) {
    type = PKNotificationTypeRSVP;
  } else if ([string isEqualToString:kPKNotificationTypeConversationAdd]) {
    type = PKNotificationTypeConversationAdd;
  } else if ([string isEqualToString:kPKNotificationTypeAnswer]) {
    type = PKNotificationTypeAnswer;
  } else if ([string isEqualToString:kPKNotificationTypeSelfKickedFromSpace]) {
    type = PKNotificationTypeSelfKickedFromSpace;
  } else if ([string isEqualToString:kPKNotificationTypeSpaceCreate]) {
    type = PKNotificationTypeSpaceCreate;
  } else if ([string isEqualToString:kPKNotificationTypeMeetingStarted]) {
    type = PKNotificationTypeMeetingStarted;
  } else if ([string isEqualToString:kPKNotificationTypeMeetingParticipantAdd]) {
    type = PKNotificationTypeMeetingParticipantAdd;
  } else if ([string isEqualToString:kPKNotificationTypeMeetingParticipantRemove]) {
    type = PKNotificationTypeMeetingParticipantRemove;
  } else if ([string isEqualToString:kPKNotificationTypeReminder]) {
    type = PKNotificationTypeReminder;
  } else if ([string isEqualToString:kPKNotificationTypeSpaceMemberRequest]) {
    type = PKNotificationTypeSpaceMemberRequest;
  } else if ([string isEqualToString:kPKNotificationTypeBatchProcess]) {
    type = PKNotificationTypeBatchProcess;
  } else if ([string isEqualToString:kPKNotificationTypeBatchComplete]) {
    type = PKNotificationTypeBatchComplete;
  }
  
  return type;
}

#pragma mark - Meetings

+ (PKExternalMeetingType)externalMeetingTypeForString:(NSString *)string {
  PKExternalMeetingType type = PKExternalMeetingTypeNone;
  
  if ([string isEqualToString:kPKExternalMeetingTypeGoToMeeting]) {
    type = PKExternalMeetingTypeGoToMeeting;
  }
  
  return type;
}

+ (PKMeetingParticipantStatus)meetingParticipantStatusForString:(NSString *)string {
  PKMeetingParticipantStatus status = PKMeetingParticipantStatusNone;
  
  if ([string isEqualToString:kPKMeetingParticipantStatusInvited]) {
    status = PKMeetingParticipantStatusInvited;
  } else if ([string isEqualToString:kPKMeetingParticipantStatusAccepted]) {
    status = PKMeetingParticipantStatusAccepted;
  } else if ([string isEqualToString:kPKMeetingParticipantStatusDeclined]) {
    status = PKMeetingParticipantStatusDeclined;
  } else if ([string isEqualToString:kPKMeetingParticipantStatusTentative]) {
    status = PKMeetingParticipantStatusTentative;
  }
  
  return status;
}

+ (NSString *)stringForMeetingParticipantStatus:(PKMeetingParticipantStatus)status {
  NSString *string = nil;
  
  switch (status) {
    case PKMeetingParticipantStatusInvited:
      string = kPKMeetingParticipantStatusInvited;
      break;
    case PKMeetingParticipantStatusAccepted:
      string = kPKMeetingParticipantStatusAccepted;
      break;
    case PKMeetingParticipantStatusDeclined:
      string = kPKMeetingParticipantStatusDeclined;
      break;
    case PKMeetingParticipantStatusTentative:
      string = kPKMeetingParticipantStatusTentative;
      break;
    default:
      break;
  }
  
  return string;
}

#pragma mark - Providers

+ (PKProviderCapability)providerCapabilityForString:(NSString *)string {
  PKProviderCapability capability = PKProviderCapabilityNone;
  
  if ([string isEqualToString:kPKProviderCapabilityFiles]) {
    capability = PKProviderCapabilityFiles;
  } else if ([string isEqualToString:kPKProviderCapabilityContacts]) {
    capability = PKProviderCapabilityContacts;
  } else if ([string isEqualToString:kPKProviderCapabilityMeetings]) {
    capability = PKProviderCapabilityMeetings;
  }
  
  return capability;
}

+ (NSString *)stringForProviderCapability:(PKProviderCapability)capability {
  NSString *string = nil;
  
  switch (capability) {
    case PKProviderCapabilityFiles:
      string = kPKProviderCapabilityFiles;
      break;
    case PKProviderCapabilityContacts:
      string = kPKProviderCapabilityContacts;
      break;
    case PKProviderCapabilityMeetings:
      string = kPKProviderCapabilityMeetings;
      break;
    default:
      break;
  }
  
  return string;
}

#pragma mark - App

+ (PKAppFieldType)appFieldTypeForString:(NSString *)string {
  PKAppFieldType type = PKAppFieldTypeNone;
  
  if ([string isEqualToString:kPKAppFieldTypeTitle]) {
    type = PKAppFieldTypeTitle;
  } else if ([string isEqualToString:kPKAppFieldTypeText]) {
    type = PKAppFieldTypeText;
  } else if ([string isEqualToString:kPKAppFieldTypeNumber]) {
    type = PKAppFieldTypeNumber;
  } else if ([string isEqualToString:kPKAppFieldTypeState]) {
    type = PKAppFieldTypeState;
  } else if ([string isEqualToString:kPKAppFieldTypeImage]) {
    type = PKAppFieldTypeImage;
  } else if ([string isEqualToString:kPKAppFieldTypeMedia]) {
    type = PKAppFieldTypeMedia;
  } else if ([string isEqualToString:kPKAppFieldTypeDate]) {
    type = PKAppFieldTypeDate;
  } else if ([string isEqualToString:kPKAppFieldTypeApp]) {
    type = PKAppFieldTypeApp;
  } else if ([string isEqualToString:kPKAppFieldTypeMember]) {
    type = PKAppFieldTypeMember;
  } else if ([string isEqualToString:kPKAppFieldTypeContact]) {
    type = PKAppFieldTypeContact;
  } else if ([string isEqualToString:kPKAppFieldTypeMoney]) {
    type = PKAppFieldTypeMoney;
  } else if ([string isEqualToString:kPKAppFieldTypeProgress]) {
    type = PKAppFieldTypeProgress;
  } else if ([string isEqualToString:kPKAppFieldTypeLocation]) {
    type = PKAppFieldTypeLocation;
  } else if ([string isEqualToString:kPKAppFieldTypeVideo]) {
    type = PKAppFieldTypeVideo;
  } else if ([string isEqualToString:kPKAppFieldTypeDuration]) {
    type = PKAppFieldTypeDuration;
  } else if ([string isEqualToString:kPKAppFieldTypeEmbed]) {
    type = PKAppFieldTypeEmbed;
  } else if ([string isEqualToString:kPKAppFieldTypeCalculation]) {
    type = PKAppFieldTypeCalculation;
  } else if ([string isEqualToString:kPKAppFieldTypeQuestion]) {
    type = PKAppFieldTypeQuestion;
  } else if ([string isEqualToString:kPKAppFieldTypeCategory]) {
    type = PKAppFieldTypeCategory;
  }
  
  return type;
}

+ (NSString *)stringForAppFieldType:(PKAppFieldType)type {
  NSString *string = nil;
  
  switch (type) {
    case PKAppFieldTypeTitle:
      string = kPKAppFieldTypeTitle;
      break;
    case PKAppFieldTypeText:
      string = kPKAppFieldTypeText;
      break;
    case PKAppFieldTypeNumber:
      string = kPKAppFieldTypeNumber;
      break;
    case PKAppFieldTypeState:
      string = kPKAppFieldTypeState;
      break;
    case PKAppFieldTypeImage:
      string = kPKAppFieldTypeImage;
      break;
    case PKAppFieldTypeMedia:
      string = kPKAppFieldTypeMedia;
      break;
    case PKAppFieldTypeDate:
      string = kPKAppFieldTypeDate;
      break;
    case PKAppFieldTypeApp:
      string = kPKAppFieldTypeApp;
      break;
    case PKAppFieldTypeMember:
      string = kPKAppFieldTypeMember;
      break;
    case PKAppFieldTypeContact:
      string = kPKAppFieldTypeContact;
      break;
    case PKAppFieldTypeMoney:
      string = kPKAppFieldTypeMoney;
      break;
    case PKAppFieldTypeProgress:
      string = kPKAppFieldTypeProgress;
      break;
    case PKAppFieldTypeLocation:
      string = kPKAppFieldTypeLocation;
      break;
    case PKAppFieldTypeVideo:
      string = kPKAppFieldTypeVideo;
      break;
    case PKAppFieldTypeDuration:
      string = kPKAppFieldTypeDuration;
      break;
    case PKAppFieldTypeEmbed:
      string = kPKAppFieldTypeEmbed;
      break;
    case PKAppFieldTypeCalculation:
      string = kPKAppFieldTypeCalculation;
      break;
    case PKAppFieldTypeQuestion:
      string = kPKAppFieldTypeQuestion;
      break;
    case PKAppFieldTypeCategory:
      string = kPKAppFieldTypeCategory;
      break;
    default:
      break;
  }
  
  return string;
}

+ (PKAppFieldStatus)appFieldStatusForString:(NSString *)string {
  PKAppFieldStatus status = PKAppFieldStatusNone;
  
  if ([string isEqualToString:kPKAppFieldStatusActive]) {
    status = PKAppFieldStatusActive;
  } else if ([string isEqualToString:kPKAppFieldStatusInactive]) {
    status = PKAppFieldStatusInactive;
  } else if ([string isEqualToString:kPKAppFieldStatusDeleted]) {
    status = PKAppFieldStatusDeleted;
  }
  
  return status;
}

+ (NSString *)stringForAppFieldStatus:(PKAppFieldStatus)status {
  NSString *string = nil;
  
  switch (status) {
    case PKAppFieldStatusActive:
      string = kPKAppFieldStatusActive;
      break;
    case PKAppFieldStatusInactive:
      string = kPKAppFieldStatusInactive;
      break;
    case PKAppFieldStatusDeleted:
      string = kPKAppFieldStatusDeleted;
      break;
    default:
      break;
  }
  
  return string;
}

#pragma mark - Images

+ (NSString *)stringForImageSize:(PKImageSize)imageSize isRetina:(BOOL)isRetina {
  NSString *string = nil;
  
  switch (imageSize) {
    case PKImageSizeDefault:
      string = kPKImageSizeDefault;
      break;
    case PKImageSizeTiny:
      string = kPKImageSizeTiny;
      break;
    case PKImageSizeSmall:
      string = kPKImageSizeSmall;
      break;
    case PKImageSizeMedium:
      string = kPKImageSizeMedium;
      break;
    case PKImageSizeBadge:
      string = kPKImageSizeBadge;
      break;
    case PKImageSizeLarge:
      string = kPKImageSizeLarge;
      break;
    case PKImageSizeExtraLarge:
      string = kPKImageSizeExtraLarge;
      break;
    case PKImageSizeIOSLarge:
      string = kPKImageSizeIOSLarge;
      break;
    default:
      break;
  }
  
  if (isRetina) {
    string = [string stringByAppendingString:@"_x2"];
  }
  
  return string;
}

@end
