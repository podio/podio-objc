//
//  PKAppFieldOptionsData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/17/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAppFieldOptionsData.h"


static NSString * const PKAppFieldOptionsDataMultipleKey = @"Multiple";
static NSString * const PKAppFieldOptionsDataOptionsKey = @"Options";

@implementation PKAppFieldOptionsData

@synthesize multiple = multiple_;
@synthesize options = options_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    multiple_ = [aDecoder decodeBoolForKey:PKAppFieldOptionsDataMultipleKey];
    options_ = [[aDecoder decodeObjectForKey:PKAppFieldOptionsDataOptionsKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeBool:multiple_ forKey:PKAppFieldOptionsDataMultipleKey];
  [aCoder encodeObject:options_ forKey:PKAppFieldOptionsDataOptionsKey];
}


@end
