//
//  PKAppFieldEmailData.m
//  PodioKit
//
//  Created by Pavel Prochazka on 09/06/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKAppFieldEmailData.h"

static NSString * const PKAppFieldEmailDataIncludeInBccKey  = @"IncludeInBcc";
static NSString * const PKAppFieldEmailDataIncludeInCcKey   = @"IncludeInCc";

@implementation PKAppFieldEmailData

@synthesize includeInBcc = includeInBcc_;
@synthesize includeInCc = includeInCc_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    includeInBcc_ = [[aDecoder decodeObjectForKey:PKAppFieldEmailDataIncludeInBccKey] boolValue];
    includeInCc_ = [[aDecoder decodeObjectForKey:PKAppFieldEmailDataIncludeInCcKey] boolValue];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:[NSNumber numberWithBool:includeInBcc_] forKey:PKAppFieldEmailDataIncludeInBccKey];
  [aCoder encodeObject:[NSNumber numberWithBool:includeInCc_] forKey:PKAppFieldEmailDataIncludeInCcKey];
}

@end
