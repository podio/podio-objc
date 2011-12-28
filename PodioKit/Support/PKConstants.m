//
//  POConstants.m
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

typedef enum {
  POTaskSectionIndexOverdue = 0,
  POTaskSectionIndexToday,
  POTaskSectionIndexTomorrow,
  POTaskSectionIndexUpcoming,
  POTaskSectionIndexLater,
} POTaskSectionIndex;

+ (NSUInteger)indexForTaskSection:(NSString *)section {
  NSUInteger index = 0;
  
  if ([section isEqualToString:@"overdue"]) {
    index = POTaskSectionIndexOverdue;
  } else if ([section isEqualToString:@"today"]) {
    index = POTaskSectionIndexToday;    
  } else if ([section isEqualToString:@"tomorrow"]) {
    index = POTaskSectionIndexTomorrow;
  } else if ([section isEqualToString:@"upcoming"]) {
    index = POTaskSectionIndexUpcoming;
  } else if ([section isEqualToString:@"later"]) {
    index = POTaskSectionIndexLater;
  } else {
    // Default
    index = POTaskSectionIndexLater;
  }
  
  return index;
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
  }
  
  return type;
}

@end
