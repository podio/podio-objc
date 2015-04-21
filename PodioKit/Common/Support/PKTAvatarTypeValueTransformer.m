//
//  PKTAvatarTypeValueTransformer.m
//  PodioKit
//
//  Created by Romain Briche on 21/04/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAvatarTypeValueTransformer.h"
#import "PKTConstants.h"

@implementation PKTAvatarTypeValueTransformer

- (instancetype)init {
  return [super initWithDictionary:@{
    @"file": @(PKTAvatarTypeFile),
    @"icon": @(PKTAvatarTypeIcon)
  }];
}

@end
