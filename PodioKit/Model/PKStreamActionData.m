//
//  PKStreamActionData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKStreamActionData.h"
#import "PKReferenceDataFactory.h"


static NSString * const PKStreamActionDataActionId = @"ActionId";
static NSString * const PKStreamActionDataType = @"Type";
static NSString * const PKStreamActionDataReferenceType = @"ReferenceType";
static NSString * const PKStreamActionDataReference = @"Reference";

@implementation PKStreamActionData

@synthesize actionId = actionId_;
@synthesize type = type_;
@synthesize referenceType = referenceType_;
@synthesize reference = reference_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    actionId_ = [aDecoder decodeIntegerForKey:PKStreamActionDataActionId];
    type_ = [aDecoder decodeIntForKey:PKStreamActionDataType];
    referenceType_ = [aDecoder decodeIntForKey:PKStreamActionDataReferenceType];
    reference_ = [aDecoder decodeObjectForKey:PKStreamActionDataReference];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:actionId_ forKey:PKStreamActionDataActionId];
  [aCoder encodeInt:type_ forKey:PKStreamActionDataType];
  [aCoder encodeInt:referenceType_ forKey:PKStreamActionDataReferenceType];
  [aCoder encodeObject:reference_ forKey:PKStreamActionDataReference];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamActionData *data = [self data];
  
  data.actionId = [[dict pk_objectForKey:@"action_id"] integerValue];
  data.type = [PKConstants actionTypeForString:[dict pk_objectForKey:@"type"]];
  
  data.referenceType = PKReferenceTypeNone;
  
  if (data.type == PKActionTypeAppCreated ||
      data.type == PKActionTypeAppInstalled ||
      data.type == PKActionTypeAppUpdated ||
      data.type == PKActionTypeAppDeactivated ||
      data.type == PKActionTypeAppActivated ||
      data.type == PKActionTypeAppDeleted) {
    // App
    data.referenceType = PKReferenceTypeApp;
  } else if (data.type == PKActionTypeMemberAdded ||
             data.type == PKActionTypeMemberLeft ||
             data.type == PKActionTypeMemberKicked ||
             data.type == PKActionTypeMemberJoined) {
    // Profile
    data.referenceType = PKReferenceTypeProfile;
  } else if (data.type == PKActionTypeSpaceCreated) {
    // Space
    data.referenceType = PKReferenceTypeSpace;
  }
  
  if (data.referenceType != PKReferenceTypeNone) {
    data.reference = [PKReferenceDataFactory dataForDictionary:[dict pk_objectForKey:@"data"] referenceType:data.referenceType];
  }
  
  return data;
}

@end
