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
  id referenceTypeValue = [[NSValueTransformer pkt_referenceTypeTransformer] transformedValue:string];

  PKTReferenceType referenceType = PKTReferenceTypeUnknown;
  if ([referenceTypeValue isKindOfClass:[NSNumber class]]) {
    referenceType = [referenceTypeValue unsignedIntegerValue];
  }

  return referenceType;
}

+ (NSString *)pkt_stringFromReferenceType:(PKTReferenceType)referenceType {
  return [[NSValueTransformer pkt_referenceTypeTransformer] reverseTransformedValue:@(referenceType)];
}

@end
