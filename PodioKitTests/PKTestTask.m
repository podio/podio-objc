//
//  PKTask.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/11/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTestTask.h"

@implementation PKTestTask

@synthesize taskId = taskId_;
@synthesize text = text_;
@synthesize type = type_;
@synthesize status = status_;
@synthesize createdOn = createdOn_;

#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObject:@"taskId"];
}

@end
