//
//  POStreamDataFactory.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamDataFactory.h"
#import "PKStreamItemData.h"
#import "PKStreamStatusData.h"
#import "PKStreamTaskData.h"
#import "PKStreamActionData.h"

@implementation PKStreamDataFactory

+ (id)dataFromDictionary:(NSDictionary *)dict objectType:(PKReferenceType)objectType {
  id data = nil;
  
  if (objectType == PKReferenceTypeItem) {
    data = [PKStreamItemData dataFromDictionary:dict];
  } else if (objectType == PKReferenceTypeStatus) {
    data = [PKStreamStatusData dataFromDictionary:dict];
  } else if (objectType == PKReferenceTypeTask) {
    data = [PKStreamTaskData dataFromDictionary:dict];
  } else if (objectType == PKReferenceTypeAction) {
    data = [PKStreamActionData dataFromDictionary:dict];
  }
  
  return data;
}

@end
