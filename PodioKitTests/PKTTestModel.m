//
//  PKTTestModel.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTestModel.h"
#import "PKTNestedTestModel.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTTestModel

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"objectID": @"object_id",
    @"firstValue": @"first_value",
    @"secondValue": @"second_value",
    @"nestedObjects": @"nested_objects",
    @"nestedObject": @"nested_object",
  };
}

+ (NSValueTransformer *)nestedObjectsValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTNestedTestModel class]];
}

+ (NSValueTransformer *)nestedObjectValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTNestedTestModel class]];
}

@end
