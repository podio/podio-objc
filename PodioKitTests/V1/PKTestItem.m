//
//  PKTestItem.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKTestItem.h"

@implementation PKTestItem

@synthesize itemId = itemId_;
@synthesize title = title_;
@synthesize fields = fields_;
@synthesize app = app_;

- (id)init {
  self = [super init];
  if (self) {
    itemId_ = nil;
    title_ = nil;
    fields_ = nil;
    app_ = nil;
  }
  return self;
}

#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObjects:@"itemId", nil];
}

@end
