//
//  PKTNestedTestModel.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 23/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNestedTestModel.h"

@implementation PKTNestedTestModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"objectID": @"object_id",
    @"firstValue": @"first_value",
  };
}

@end
