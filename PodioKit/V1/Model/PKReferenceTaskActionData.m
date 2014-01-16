//
//  PKReferenceTaskActionData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKReferenceTaskActionData.h"

static NSString * const PKReferenceTaskActionDataTaskActionId = @"TaskActionId";
static NSString * const PKReferenceTaskActionDataType = @"Type";
static NSString * const PKReferenceTaskActionDataChanged = @"Changed";

@implementation PKReferenceTaskActionData

@synthesize taskActionId = taskActionId_;
@synthesize type = type_;
@synthesize changed = changed_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    taskActionId_ = [aDecoder decodeIntegerForKey:PKReferenceTaskActionDataTaskActionId];
    type_ = [aDecoder decodeIntegerForKey:PKReferenceTaskActionDataType];
    changed_ = [[aDecoder decodeObjectForKey:PKReferenceTaskActionDataChanged] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskActionId_ forKey:PKReferenceTaskActionDataTaskActionId];
  [aCoder encodeInteger:type_ forKey:PKReferenceTaskActionDataType];
  [aCoder encodeObject:changed_ forKey:PKReferenceTaskActionDataChanged];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKReferenceTaskActionData *data = [self data];
  
  data.taskActionId = [[dict pk_objectForKey:@"task_action_id"] integerValue];
  data.type = [PKConstants taskActionTypeForString:[dict pk_objectForKey:@"type"]];
  data.changed = [dict pk_objectForKey:@"changed"];
  
  return data;
}

@end
