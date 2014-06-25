//
//  PKTAppFieldTypeValueTransformer.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 09/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTAppFieldTypeValueTransformer.h"
#import "PKTAppField.h"

@implementation PKTAppFieldTypeValueTransformer

- (instancetype)init {
  return [super initWithDictionary:@{
    @"text" : @(PKTAppFieldTypeText),
    @"number" : @(PKTAppFieldTypeNumber),
    @"image" : @(PKTAppFieldTypeImage),
    @"date" : @(PKTAppFieldTypeDate),
    @"app" : @(PKTAppFieldTypeApp),
    @"contact" : @(PKTAppFieldTypeContact),
    @"money" : @(PKTAppFieldTypeMoney),
    @"progress" : @(PKTAppFieldTypeProgress),
    @"location" : @(PKTAppFieldTypeLocation),
    @"duration" : @(PKTAppFieldTypeDuration),
    @"embed" : @(PKTAppFieldTypeEmbed),
    @"calculation" : @(PKTAppFieldTypeCalculation),
    @"category" : @(PKTAppFieldTypeCategory)
  }];
}

@end
