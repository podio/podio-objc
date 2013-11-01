//
//  PKPromotionAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/11/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKPromotionAPI.h"

@implementation PKPromotionAPI

+ (PKRequest *)requestForPromotionInContextType:(NSString *)context {
  return [PKRequest getRequestWithURI:[NSString stringWithFormat:@"/promotion/%@", [PKConstants stringForPromotionContext:context]]];
}

+ (PKRequest *)requestToClickPromotionWithId:(NSUInteger)promotionId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/promotion/%ld/click", promotionId]];
}

+ (PKRequest *)requestToEndPromotionWithId:(NSUInteger)promotionId {
  return [PKRequest postRequestWithURI:[NSString stringWithFormat:@"/promotion/%ld/end", promotionId]];
}

@end
