//
//  POAppFieldCategoryData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 8/17/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAppFieldOptionsData.h"


static NSString * const POAppFieldCategoryDataMultipleKey = @"Multiple";
static NSString * const POAppFieldCategoryDataOptionsKey = @"Options";

@implementation PKAppFieldOptionsData

@synthesize multiple = multiple_;
@synthesize options = options_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    multiple_ = [aDecoder decodeBoolForKey:POAppFieldCategoryDataMultipleKey];
    options_ = [[aDecoder decodeObjectForKey:POAppFieldCategoryDataOptionsKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeBool:multiple_ forKey:POAppFieldCategoryDataMultipleKey];
  [aCoder encodeObject:options_ forKey:POAppFieldCategoryDataOptionsKey];
}

- (void)dealloc {
  [options_ release];
  [super dealloc];
}

@end
