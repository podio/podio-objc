//
//  PKStreamTaskData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKStreamTaskData.h"
#import "NSDate+PKAdditions.h"


static NSString * const PKStreamTaskDataTaskId = @"TaskId";
static NSString * const PKStreamTaskDataStatus = @"Status";
static NSString * const PKStreamTaskDataText = @"Text";
static NSString * const PKStreamTaskDataDescription = @"Description";
static NSString * const PKStreamTaskDataDueDate = @"DueDate";
static NSString * const PKStreamTaskDataResponsibleUserId = @"ResponsibleUserId";
static NSString * const PKStreamTaskDataResponsibleAvatarFileId = @"ResponsibleAvatarFileId";
static NSString * const PKStreamTaskDataResponsibleName = @"ResponsibleName";

@implementation PKStreamTaskData

@synthesize taskId = taskId_;
@synthesize status = status_;
@synthesize text = text_;
@synthesize description = description_;
@synthesize dueDate = dueDate_;
@synthesize responsibleUserId = responsibleUserId_;
@synthesize responsibleAvatarFileId = responsibleAvatarFileId_;
@synthesize responsibleName = responsibleName_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    taskId_ = [aDecoder decodeIntegerForKey:PKStreamTaskDataTaskId];
    status_ = [aDecoder decodeIntForKey:PKStreamTaskDataStatus];
    text_ = [[aDecoder decodeObjectForKey:PKStreamTaskDataText] copy];
    description_ = [[aDecoder decodeObjectForKey:PKStreamTaskDataDescription] copy];
    dueDate_ = [[aDecoder decodeObjectForKey:PKStreamTaskDataDueDate] copy];
    responsibleUserId_ = [aDecoder decodeIntegerForKey:PKStreamTaskDataResponsibleUserId];
    responsibleAvatarFileId_ = [aDecoder decodeIntegerForKey:PKStreamTaskDataResponsibleAvatarFileId];
    responsibleName_ = [[aDecoder decodeObjectForKey:PKStreamTaskDataResponsibleName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskId_ forKey:PKStreamTaskDataTaskId];
  [aCoder encodeInt:status_ forKey:PKStreamTaskDataStatus];
  [aCoder encodeObject:text_ forKey:PKStreamTaskDataText];
  [aCoder encodeObject:description_ forKey:PKStreamTaskDataDescription];
  [aCoder encodeObject:dueDate_ forKey:PKStreamTaskDataDueDate];
  [aCoder encodeInteger:responsibleUserId_ forKey:PKStreamTaskDataResponsibleUserId];
  [aCoder encodeInteger:responsibleAvatarFileId_ forKey:PKStreamTaskDataResponsibleAvatarFileId];
  [aCoder encodeObject:responsibleName_ forKey:PKStreamTaskDataResponsibleName];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamTaskData *data = [PKStreamTaskData data];
  
  data.taskId = [[dict pk_objectForKey:@"task_id"] integerValue];
  data.status = [PKConstants taskStatusForString:[dict pk_objectForKey:@"status"]];
  data.text = [dict pk_objectForKey:@"text"];
  data.description = [dict pk_objectForKey:@"description"];
  data.dueDate = [NSDate pk_dateWithDateString:[dict pk_objectForKey:@"due_date"]];
  
  NSDictionary *responsibleDict = [dict pk_objectForKey:@"responsible"];
  data.responsibleUserId = [[responsibleDict pk_objectForKey:@"user_id"] integerValue];
  data.responsibleAvatarFileId = [[responsibleDict pk_objectForKey:@"avatar"] integerValue];
  data.responsibleName = [responsibleDict pk_objectForKey:@"name"];
  
  return data;
}

@end
