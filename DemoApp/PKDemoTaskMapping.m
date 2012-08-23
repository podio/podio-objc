//
//  PKDemoTaskMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/6/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKDemoTaskMapping.h"

@implementation PKDemoTaskMapping

+ (BOOL)shouldPerformMappingWithData:(NSDictionary *)data {
  // Filter out all tasks that are not active
  return [[data pk_objectForKey:@"status"] isEqualToString:@"active"];
}

- (void)buildMappings {
  // Simple property mappings
  [self hasProperty:@"taskId" forAttribute:@"task_id"];
  [self hasProperty:@"text" forAttribute:@"text"];  
  [self hasDateProperty:@"createdOn" forAttribute:@"created_on" isUTC:YES];
  
  // Use a block to transform value before populating property
  [self hasProperty:@"status" forAttribute:@"status" block:^id(id attrVal, NSDictionary *objDict, id parent) {
    PKTaskStatus status = [PKConstants taskStatusForString:attrVal];
    return [NSNumber numberWithInt:status];
  }];
}

@end
