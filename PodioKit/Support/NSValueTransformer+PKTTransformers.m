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
#import "PKTNumberValueTransformer.h"

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
  return [PKTURLValueTransformer new];
}

+ (NSValueTransformer *)pkt_dateValueTransformer {
  return [PKTDateValueTransformer new];
}

+ (NSValueTransformer *)pkt_referenceTypeTransformer {
  return [PKTReferenceTypeValueTransformer new];
}

+ (NSValueTransformer *)pkt_appFieldTypeTransformer {
  return [PKTAppFieldTypeValueTransformer new];
}

+ (NSValueTransformer *)pkt_numberValueTransformer {
  return [PKTNumberValueTransformer new];
}
@end
