//
//  POStreamActivityTaskActionData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKReferenceTaskActionData.h"

static NSString * const POStreamActivityTaskActionDataTaskActionId = @"TaskActionId";
static NSString * const POStreamActivityTaskActionDataType = @"Type";
static NSString * const POStreamActivityTaskActionDataChanged = @"Changed";

@implementation PKReferenceTaskActionData

@synthesize taskActionId = taskActionId_;
@synthesize type = type_;
@synthesize changed = changed_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    taskActionId_ = [aDecoder decodeIntegerForKey:POStreamActivityTaskActionDataTaskActionId];
    type_ = [aDecoder decodeIntegerForKey:POStreamActivityTaskActionDataType];
    changed_ = [[aDecoder decodeObjectForKey:POStreamActivityTaskActionDataChanged] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:taskActionId_ forKey:POStreamActivityTaskActionDataTaskActionId];
  [aCoder encodeInteger:type_ forKey:POStreamActivityTaskActionDataType];
  [aCoder encodeObject:changed_ forKey:POStreamActivityTaskActionDataChanged];
}

- (void)dealloc {
  [changed_ release];
  [super dealloc];
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
