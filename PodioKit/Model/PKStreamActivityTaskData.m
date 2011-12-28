//
//  POStreamActivityTaskData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityTaskData.h"
#import "NSDate+PKAdditions.h"


static NSString * const POStreamActivityTaskDataTaskId = @"TaskId";
static NSString * const POStreamActivityTaskDataStatus = @"Status";
static NSString * const POStreamActivityTaskDataText = @"Text";
static NSString * const POStreamActivityTaskDataDescription = @"Description";
static NSString * const POStreamActivityTaskDataDueDate = @"DueDate";
static NSString * const POStreamActivityTaskDataResponsibleUserId = @"ResponsibleUserId";
static NSString * const POStreamActivityTaskDataResponsibleAvatarFileId = @"ResponsibleAvatarFileId";
static NSString * const POStreamActivityTaskDataResponsibleName = @"ResponsibleName";

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
    taskId_ = [aDecoder decodeIntegerForKey:POStreamActivityTaskDataTaskId];
    status_ = [aDecoder decodeIntegerForKey:POStreamActivityTaskDataStatus];
    text_ = [[aDecoder decodeObjectForKey:POStreamActivityTaskDataText] copy];
    description_ = [[aDecoder decodeObjectForKey:POStreamActivityTaskDataDescription] copy];
    dueDate_ = [[aDecoder decodeObjectForKey:POStreamActivityTaskDataDueDate] copy];
    responsibleUserId_ = [aDecoder decodeIntegerForKey:POStreamActivityTaskDataResponsibleUserId];
    responsibleAvatarFileId_ = [aDecoder decodeIntegerForKey:POStreamActivityTaskDataResponsibleAvatarFileId];
    responsibleName_ = [[aDecoder decodeObjectForKey:POStreamActivityTaskDataResponsibleName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskId_ forKey:POStreamActivityTaskDataTaskId];
  [aCoder encodeInteger:status_ forKey:POStreamActivityTaskDataStatus];
  [aCoder encodeObject:text_ forKey:POStreamActivityTaskDataText];
  [aCoder encodeObject:description_ forKey:POStreamActivityTaskDataDescription];
  [aCoder encodeObject:dueDate_ forKey:POStreamActivityTaskDataDueDate];
  [aCoder encodeInteger:responsibleUserId_ forKey:POStreamActivityTaskDataResponsibleUserId];
  [aCoder encodeInteger:responsibleAvatarFileId_ forKey:POStreamActivityTaskDataResponsibleAvatarFileId];
  [aCoder encodeObject:responsibleName_ forKey:POStreamActivityTaskDataResponsibleName];
}

- (void)dealloc {
  [text_ release];
  [description_ release];
  [dueDate_ release];
  [responsibleName_ release];
  [super dealloc];
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
