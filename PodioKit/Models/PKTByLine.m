//
//  PKTByLine.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTByLine.h"
#import "PKTFile.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTByLine

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"referenceType" : @"type",
           @"referenceID" : @"id",
           @"userID" : @"user_id",
           @"imageFile" : @"image"
           };
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

+ (NSValueTransformer *)imageFileValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

@end
