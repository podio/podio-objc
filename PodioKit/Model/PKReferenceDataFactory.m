//
//  PKReferenceDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceDataFactory.h"
#import "PKReferenceSpaceData.h"
#import "PKReferenceTaskActionData.h"
#import "PKReferenceAppData.h"
#import "PKReferenceProfileData.h"
#import "PKReferenceItemData.h"
#import "PKReferenceMessageData.h"
#import "PKReferenceRatingData.h"
#import "PKReferenceMeetingData.h"

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
      data = [PKReferenceProfileData dataFromDictionary:dict];
      break;
    case PKReferenceTypeTaskAction:
      data = [PKReferenceTaskActionData dataFromDictionary:dict];
      break;
    case PKReferenceTypeMeeting:
      data = [PKReferenceMeetingData dataFromDictionary:dict];
      break;
    default:
      break;
  }
  
  return data;
}

@end
