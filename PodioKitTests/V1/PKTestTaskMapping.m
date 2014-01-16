//
//  PKTestTaskMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTestTaskMapping.h"
#import "NSDictionary+PKAdditions.h"

@implementation PKTestTaskMapping

- (void)buildMappings {
  [self hasProperty:@"taskId" forAttribute:@"task_id"];
  [self hasProperty:@"text" forAttribute:@"text"];  
  [self hasDateProperty:@"createdOn" forAttribute:@"created_on" isUTC:YES];

  [self hasProperty:@"status" forAttribute:@"status" block:^id(id attrVal, NSDictionary *objDict, id parent) {
    PKTaskStatus status = [PKConstants taskStatusForString:attrVal];
    return [NSNumber numberWithInt:status];
  }];
}

@end
