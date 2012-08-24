//
//  PKTestItemFieldMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTestItemFieldMapping.h"

@implementation PKTestItemFieldMapping

- (void)buildMappings {
  [self hasProperty:@"fieldId" forAttribute:@"field_id"];
  [self hasProperty:@"text" forAttribute:@"text"];
}

@end
