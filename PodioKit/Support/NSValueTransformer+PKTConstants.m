//
//  NSValueTransformer+PKTConstants.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 11/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "NSValueTransformer+PKTConstants.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation NSValueTransformer (PKTConstants)

+ (PKTReferenceType)pkt_referenceTypeFromString:(NSString *)string {
  return [[NSValueTransformer pkt_referenceTypeTransformer] transformedValue:string];
}

+ (NSString *)pkt_stringFromReferenceType:(PKTReferenceType)referenceType {
  return [[NSValueTransformer pkt_referenceTypeTransformer] reverseTransformedValue:@(referenceType)];
}

@end
