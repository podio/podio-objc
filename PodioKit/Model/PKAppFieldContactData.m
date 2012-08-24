//
//  PKAppFieldContactData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/7/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKAppFieldContactData.h"


static NSString * const PKAppFieldContactDataValidTypesKey = @"ValidTypes";

@implementation PKAppFieldContactData

@synthesize validTypes = validTypes_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    validTypes_ = [[aDecoder decodeObjectForKey:PKAppFieldContactDataValidTypesKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:validTypes_ forKey:PKAppFieldContactDataValidTypesKey];
}

@end
