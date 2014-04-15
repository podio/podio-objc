//
//  PKTTestModel.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTestModel.h"

@implementation PKTTestModel

#pragma mark - MTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"objectID": @"object_id",
    @"firstName": @"first_name",
    @"lastName": @"last_name",
  };
}

@end
