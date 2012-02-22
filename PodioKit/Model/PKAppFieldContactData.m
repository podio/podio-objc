//
//  POAppFieldContactData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/7/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKAppFieldContactData.h"


static NSString * const POAppFieldCategoryDataValidTypesKey = @"ValidTypes";

@implementation PKAppFieldContactData

@synthesize validTypes = validTypes_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    validTypes_ = [[aDecoder decodeObjectForKey:POAppFieldCategoryDataValidTypesKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:validTypes_ forKey:POAppFieldCategoryDataValidTypesKey];
}


@end
