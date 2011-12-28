//
//  PKTaskMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTaskMapping.h"
#import "NSDictionary+PKAdditions.h"

@implementation PKTaskMapping

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
