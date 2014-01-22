//
//  PKReferenceTaskData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceTaskData.h"
#import "NSDate+PKAdditions.h"


static NSString * const PKReferenceTaskDataTaskId = @"TaskId";
static NSString * const PKReferenceTaskDataStatus = @"Status";
static NSString * const PKReferenceTaskDataText = @"Text";
static NSString * const PKReferenceTaskDataDescription = @"Description";
static NSString * const PKReferenceTaskDataDueDate = @"DueDate";
static NSString * const PKReferenceTaskDataResponsibleUserId = @"ResponsibleUserId";
static NSString * const PKReferenceTaskDataResponsibleAvatarFileId = @"ResponsibleAvatarFileId";
static NSString * const PKReferenceTaskDataResponsibleName = @"ResponsibleName";

@implementation PKReferenceTaskData

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
    taskId_ = [aDecoder decodeIntegerForKey:PKReferenceTaskDataTaskId];
    status_ = [aDecoder decodeIntForKey:PKReferenceTaskDataStatus];
    text_ = [[aDecoder decodeObjectForKey:PKReferenceTaskDataText] copy];
    description_ = [[aDecoder decodeObjectForKey:PKReferenceTaskDataDescription] copy];
    dueDate_ = [[aDecoder decodeObjectForKey:PKReferenceTaskDataDueDate] copy];
    responsibleUserId_ = [aDecoder decodeIntegerForKey:PKReferenceTaskDataResponsibleUserId];
    responsibleAvatarFileId_ = [aDecoder decodeIntegerForKey:PKReferenceTaskDataResponsibleAvatarFileId];
    responsibleName_ = [[aDecoder decodeObjectForKey:PKReferenceTaskDataResponsibleName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskId_ forKey:PKReferenceTaskDataTaskId];
  [aCoder encodeInt:status_ forKey:PKReferenceTaskDataStatus];
  [aCoder encodeObject:text_ forKey:PKReferenceTaskDataText];
  [aCoder encodeObject:description_ forKey:PKReferenceTaskDataDescription];
  [aCoder encodeObject:dueDate_ forKey:PKReferenceTaskDataDueDate];
  [aCoder encodeInteger:responsibleUserId_ forKey:PKReferenceTaskDataResponsibleUserId];
  [aCoder encodeInteger:responsibleAvatarFileId_ forKey:PKReferenceTaskDataResponsibleAvatarFileId];
  [aCoder encodeObject:responsibleName_ forKey:PKReferenceTaskDataResponsibleName];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceTaskData *data = [self data];
  
  data.taskId = [[dict pk_objectForKey:@"task_id"] integerValue];
  data.status = [PKConstants taskStatusForString:[dict pk_objectForKey:@"status"]];
  data.text = [dict pk_objectForKey:@"text"];
  data.description = [dict pk_objectForKey:@"description"];
  data.dueDate = [NSDate pk_localDateFromUTCDateString:[dict pk_objectForKey:@"created_on"]];
  
  NSDictionary *responsibleDict = [dict pk_objectForKey:@"responsible"];
  data.responsibleUserId = [[responsibleDict pk_objectForKey:@"user_id"] integerValue];
  data.responsibleAvatarFileId = [[responsibleDict pk_objectForKey:@"avatar"] integerValue];
  data.responsibleName = [responsibleDict pk_objectForKey:@"name"];
  
  return data;
}

@end
