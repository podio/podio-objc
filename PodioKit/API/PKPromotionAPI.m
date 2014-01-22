//
//  PKPromotionAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/11/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKPromotionAPI.h"

@implementation PKPromotionAPI

+ (PKRequest *)requestForPromotionInContext:(PKPromotionContext)context {
  return [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/promotion/%@", [PKConstants stringForPromotionContext:context]]];
}

+ (PKRequest *)requestToClickPromotionWithId:(NSUInteger)promotionId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/promotion/%lu/click", (unsigned long)promotionId]];
}

+ (PKRequest *)requestToEndPromotionWithId:(NSUInteger)promotionId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/promotion/%lu/end", (unsigned long)promotionId]];
}

@end
