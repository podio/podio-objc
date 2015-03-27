//
//  PKTAction.h
//  PodioKit
//
//  Created by Romain Briche on 27/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTModel.h"

@class PKTByLine;

typedef NS_ENUM(NSInteger, PKTActionType) {
  PKTActionTypeUnknown = 0,
  PKTActionTypeSpaceCreated,
  PKTActionTypeMemberAdded,
  PKTActionTypeMemberLeft,
  PKTActionTypeMemberKicked,
  PKTActionTypeAppCreated,
  PKTActionTypeAppUpdated,
  PKTActionTypeAppDeleted,
  PKTActionTypeAppInstalled,
  PKTActionTypeAppActivated,
  PKTActionTypeAppDeactivated
};

@interface PKTAction : PKTModel

@property (nonatomic, assign, readonly) NSUInteger actionID;
@property (nonatomic, assign, readonly) PKTActionType actionType;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, strong, readonly) PKTByLine *createdBy;
@property (nonatomic, copy, readonly) NSDate *createdOn;
@property (nonatomic, copy, readonly) NSArray *comments;

@end
