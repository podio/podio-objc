//
//  PKTestItemField.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/21/11.
//  Copyright (c) 2011 Podio. All rights reserved.
//

#import "PKTestItemField.h"

@implementation PKTestItemField

@synthesize fieldId = fieldId_;
@synthesize text = text_;

- (id)init {
  self = [super init];
  if (self) {
    fieldId_ = nil;
    text_ = nil;
  }
  return self;
}

#pragma mark - PKMappableObject

+ (NSArray *)identityPropertyNames {
  return [NSArray arrayWithObjects:@"fieldId", nil];
}

@end
