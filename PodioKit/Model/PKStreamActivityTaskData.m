//
//  PKStreamActivityTaskData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityTaskData.h"
#import "NSDate+PKAdditions.h"


static NSString * const PKStreamActivityTaskDataTaskId = @"TaskId";
static NSString * const PKStreamActivityTaskDataStatus = @"Status";
static NSString * const PKStreamActivityTaskDataText = @"Text";
static NSString * const PKStreamActivityTaskDataDescription = @"Description";
static NSString * const PKStreamActivityTaskDataDueDate = @"DueDate";
static NSString * const PKStreamActivityTaskDataResponsibleUserId = @"ResponsibleUserId";
static NSString * const PKStreamActivityTaskDataResponsibleAvatarFileId = @"ResponsibleAvatarFileId";
static NSString * const PKStreamActivityTaskDataResponsibleName = @"ResponsibleName";

@implementation PKStreamActivityTaskData

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
    taskId_ = [aDecoder decodeIntegerForKey:PKStreamActivityTaskDataTaskId];
    status_ = [aDecoder decodeIntegerForKey:PKStreamActivityTaskDataStatus];
    text_ = [[aDecoder decodeObjectForKey:PKStreamActivityTaskDataText] copy];
    description_ = [[aDecoder decodeObjectForKey:PKStreamActivityTaskDataDescription] copy];
    dueDate_ = [[aDecoder decodeObjectForKey:PKStreamActivityTaskDataDueDate] copy];
    responsibleUserId_ = [aDecoder decodeIntegerForKey:PKStreamActivityTaskDataResponsibleUserId];
    responsibleAvatarFileId_ = [aDecoder decodeIntegerForKey:PKStreamActivityTaskDataResponsibleAvatarFileId];
    responsibleName_ = [[aDecoder decodeObjectForKey:PKStreamActivityTaskDataResponsibleName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskId_ forKey:PKStreamActivityTaskDataTaskId];
  [aCoder encodeInteger:status_ forKey:PKStreamActivityTaskDataStatus];
  [aCoder encodeObject:text_ forKey:PKStreamActivityTaskDataText];
  [aCoder encodeObject:description_ forKey:PKStreamActivityTaskDataDescription];
  [aCoder encodeObject:dueDate_ forKey:PKStreamActivityTaskDataDueDate];
  [aCoder encodeInteger:responsibleUserId_ forKey:PKStreamActivityTaskDataResponsibleUserId];
  [aCoder encodeInteger:responsibleAvatarFileId_ forKey:PKStreamActivityTaskDataResponsibleAvatarFileId];
  [aCoder encodeObject:responsibleName_ forKey:PKStreamActivityTaskDataResponsibleName];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamActivityTaskData *data = [self data];
  
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
