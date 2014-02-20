//
//  PKReferenceDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceDataFactory.h"
#import "PKReferenceSpaceData.h"
#import "PKReferenceTaskActionData.h"
#import "PKReferenceAppData.h"
#import "PKReferenceProfileData.h"
#import "PKReferenceItemData.h"
#import "PKReferenceMessageData.h"
#import "PKReferenceRatingData.h"
#import "PKReferenceTaskData.h"
#import "PKReferenceCommentData.h"
#import "PKReferenceAnswerData.h"
#import "PKReferenceItemParticipationData.h"
#import "PKFileData.h"

@implementation PKReferenceDataFactory

+ (id)dataForDictionary:(NSDictionary *)dict referenceType:(PKReferenceType)referenceType {
  id data = nil;
  
  switch (referenceType) {
    case PKReferenceTypeItem:
      data = [PKReferenceItemData dataFromDictionary:dict];
      break;
    case PKReferenceTypeSpace:
      data = [PKReferenceSpaceData dataFromDictionary:dict];
      break;
    case PKReferenceTypeApp:
      data = [PKReferenceAppData dataFromDictionary:dict];
      break;
    case PKReferenceTypeMessage:
      data = [PKReferenceMessageData dataFromDictionary:dict];
      break;
    case PKReferenceTypeRating:
      data = [PKReferenceRatingData dataFromDictionary:dict];
      break;
    case PKReferenceTypeProfile:
      data = [PKReferenceProfileData dataFromDictionary:[dict pk_objectForKey:@"user"]];
      break;
    case PKReferenceTypeTaskAction:
      data = [PKReferenceTaskActionData dataFromDictionary:dict];
      break;
    case PKReferenceTypeComment:
      data = [PKReferenceCommentData dataFromDictionary:dict];
      break;
    case PKReferenceTypeFile:
      data = [PKFileData dataFromDictionary:dict];
      break;
    case PKReferenceTypeTask:
      data = [PKReferenceTaskData dataFromDictionary:dict];
      break;
    case PKReferenceTypeQuestionAnswer:
      data = [PKReferenceAnswerData dataFromDictionary:dict];
      break;
    case PKReferenceTypeItemParticipation:
      data = [PKReferenceItemParticipationData dataFromDictionary:dict];
      break;
    default:
      break;
  }
  
  return data;
}

@end
