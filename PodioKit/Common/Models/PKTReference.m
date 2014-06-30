//
//  PKTReference.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTReference.h"
#import "PKTReferenceObjectFactory.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTReference

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"referenceID" : @"id",
           @"referenceType" : @"type",
           @"referenceObject" : @"data",
           };
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

+ (NSValueTransformer *)referenceObjectValueTransformer {
  return [NSValueTransformer pkt_transformerWithBlock:^id(NSDictionary *refDict) {
    return [PKTReferenceObjectFactory referenceObjectFromDictionary:refDict];
  }];
}

@end
