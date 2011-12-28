//
//  POStreamActivityDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityDataFactory.h"
#import "PKStreamActivityTaskData.h"
#import "PKStreamActivityFileData.h"
#import "PKReferenceCommentData.h"
#import "PKReferenceRatingData.h"
#import "PKStreamActivityAnswerData.h"


@implementation PKStreamActivityDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict activityType:(PKStreamActivityType)activityType {
  id data = nil;
  
  if (activityType == PKStreamActivityTypeComment) {
    data = [PKReferenceCommentData dataFromDictionary:dict];
  }
  else if (activityType == PKStreamActivityTypeFile) {
    data = [PKStreamActivityFileData dataFromDictionary:dict];
  }
  else if (activityType == PKStreamActivityTypeRating) {
    data = [PKReferenceRatingData dataFromDictionary:dict];
  }
  else if (activityType == PKStreamActivityTypeCreation) {
  }
  else if (activityType == PKStreamActivityTypeUpdate) {
  }
  else if (activityType == PKStreamActivityTypeTask) {
    data = [PKStreamActivityTaskData dataFromDictionary:dict];
  }
  else if (activityType == PKStreamActivityTypeAnswer) {
    data = [PKStreamActivityAnswerData dataFromDictionary:dict];
  }
  
  return data;
}

@end
