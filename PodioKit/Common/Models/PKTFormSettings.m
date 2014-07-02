//
//  PKTFormSettings.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFormSettings.h"

@implementation PKTFormSettings

#pragma mark - PKTModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
  return [super initWithDictionary:dictionary];
}

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"titleText" : @"text.heading",
           @"descriptionText" : @"text.description",
           @"successText" : @"text.success",
           @"submitText" : @"text.submit",
           };
}

@end
