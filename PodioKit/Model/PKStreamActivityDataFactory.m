//
//  PKStreamActivityDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityDataFactory.h"
#import "PKStreamActivityTaskData.h"
#import "PKReferenceCommentData.h"
#import "PKReferenceRatingData.h"
#import "PKFileData.h"
#import "PKStreamActivityAnswerData.h"


@implementation PKStreamActivityDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict activityType:(PKStreamActivityType)activityType {
  id data = nil;
  
  switch (activityType) {
    case PKStreamActivityTypeComment:
      data = [PKReferenceCommentData dataFromDictionary:dict];
      break;
    case PKStreamActivityTypeFile:
      data = [PKFileData dataFromDictionary:dict];
      break;
    case PKStreamActivityTypeRating:
      data = [PKReferenceRatingData dataFromDictionary:dict];
      break;
    case PKStreamActivityTypeTask:
      data = [PKStreamActivityTaskData dataFromDictionary:dict];
      break;
    case PKStreamActivityTypeAnswer:
      data = [PKStreamActivityAnswerData dataFromDictionary:dict];
      break;
    default:
      break;
  }
  
  return data;
}

@end
