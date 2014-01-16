//
//  PKReferenceTaskData.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKObjectData.h"

@interface PKReferenceTaskData : PKObjectData {

 @private
  NSInteger taskId_;
  PKTaskStatus status_;
  NSString *text_;
  NSString *description_;
  NSDate *dueDate_;
  NSInteger responsibleUserId_;
  NSInteger responsibleAvatarFileId_;
  NSString *responsibleName_;
}

@property (nonatomic) NSInteger taskId;
@property (nonatomic) PKTaskStatus status;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *description;
@property (nonatomic, copy) NSDate *dueDate;
@property (nonatomic) NSInteger responsibleUserId;
@property (nonatomic) NSInteger responsibleAvatarFileId;
@property (nonatomic, copy) NSString *responsibleName;

@end
