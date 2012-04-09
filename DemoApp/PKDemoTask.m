//
//  PKDemoTask.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 4/6/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKDemoTask.h"

@implementation PKDemoTask

@synthesize taskId = taskId_;
@synthesize text = text_;
@synthesize status = status_;
@synthesize createdOn = createdOn_;

#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObject:@"taskId"];
}

@end
