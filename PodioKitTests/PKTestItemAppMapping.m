//
//  PKTestItemAppMapping.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTestItemAppMapping.h"

@implementation PKTestItemAppMapping

- (void)buildMappings {
  [self hasProperty:@"appId" forAttribute:@"app_id"];
  [self hasProperty:@"name" forAttribute:@"name"];
}

@end
