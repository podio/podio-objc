//
//  PKTReferenceTypeValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReferenceTypeValueTransformer.h"
#import "PKTConstants.h"

@implementation PKTReferenceTypeValueTransformer

- (instancetype)init {
  return [super initWithDictionary:@{
    @"app": @(PKTReferenceTypeApp),
    @"item": @(PKTReferenceTypeItem),
  }];
}

@end
