//
//  NSValueTransformer+PKTTransformers.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 15/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSValueTransformer+PKTTransformers.h"
#import "PKTAppField.h"
#import "PKTConstants.h"

@implementation NSValueTransformer (PKTTransformers)

+ (NSValueTransformer *)pkt_transformerWithBlock:(PKTValueTransformationBlock)block {
  return [PKTBlockValueTransformer transformerWithBlock:block];
}

+ (NSValueTransformer *)pkt_transformerWithBlock:(PKTValueTransformationBlock)block reverseBlock:(PKTValueTransformationBlock)reverseBlock {
  return [PKTReversibleBlockValueTransformer transformerWithBlock:block reverseBlock:reverseBlock];
}

+ (NSValueTransformer *)pkt_transformerWithModelClass:(Class)modelClass {
  return [PKTModelValueTransformer transformerWithModelClass:modelClass];
}

+ (NSValueTransformer *)pkt_transformerWithDictionary:(NSDictionary *)dictionary {
  return [PKTDictionaryMappingValueTransformer transformerWithDictionary:dictionary];
}

+ (NSValueTransformer *)pkt_URLTransformer {
  return [[PKTURLValueTransformer alloc] init];
}

+ (NSValueTransformer *)pkt_referenceTypeTransformer {
  return [[PKTReferenceTypeValueTransformer alloc] init];
}

+ (NSValueTransformer *)pkt_appFieldTypeTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
    @"title" : @(PKTAppFieldTypeTitle),
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
    @"category" : @(PKTAppFieldTypeCategory),
  }];
}

@end
