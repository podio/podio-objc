//
//  POStreamTaskData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamTaskData.h"
#import "NSDate+PKAdditions.h"


static NSString * const POStreamTaskDataTaskId = @"TaskId";
static NSString * const POStreamTaskDataStatus = @"Status";
static NSString * const POStreamTaskDataText = @"Text";
static NSString * const POStreamTaskDataDescription = @"Description";
static NSString * const POStreamTaskDataDueDate = @"DueDate";
static NSString * const POStreamTaskDataResponsibleUserId = @"ResponsibleUserId";
static NSString * const POStreamTaskDataResponsibleAvatarFileId = @"ResponsibleAvatarFileId";
static NSString * const POStreamTaskDataResponsibleName = @"ResponsibleName";

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
    taskId_ = [aDecoder decodeIntegerForKey:POStreamTaskDataTaskId];
    status_ = [aDecoder decodeIntegerForKey:POStreamTaskDataStatus];
    text_ = [[aDecoder decodeObjectForKey:POStreamTaskDataText] copy];
    description_ = [[aDecoder decodeObjectForKey:POStreamTaskDataDescription] copy];
    dueDate_ = [[aDecoder decodeObjectForKey:POStreamTaskDataDueDate] copy];
    responsibleUserId_ = [aDecoder decodeIntegerForKey:POStreamTaskDataResponsibleUserId];
    responsibleAvatarFileId_ = [aDecoder decodeIntegerForKey:POStreamTaskDataResponsibleAvatarFileId];
    responsibleName_ = [[aDecoder decodeObjectForKey:POStreamTaskDataResponsibleName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskId_ forKey:POStreamTaskDataTaskId];
  [aCoder encodeInteger:status_ forKey:POStreamTaskDataStatus];
  [aCoder encodeObject:text_ forKey:POStreamTaskDataText];
  [aCoder encodeObject:description_ forKey:POStreamTaskDataDescription];
  [aCoder encodeObject:dueDate_ forKey:POStreamTaskDataDueDate];
  [aCoder encodeInteger:responsibleUserId_ forKey:POStreamTaskDataResponsibleUserId];
  [aCoder encodeInteger:responsibleAvatarFileId_ forKey:POStreamTaskDataResponsibleAvatarFileId];
  [aCoder encodeObject:responsibleName_ forKey:POStreamTaskDataResponsibleName];
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
