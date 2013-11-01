//
//  PKPromotionAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 01/11/13.
//  Copyright (c) 2013 Citrix Systems, Inc. All rights reserved.
//

#import "PKBaseAPI.h"

@interface PKPromotionAPI : PKBaseAPI

+ (PKRequest *)requestForPromotionInContextType:(NSString *)context;
+ (PKRequest *)requestToClickPromotionWithId:(NSUInteger)promotionId;
+ (PKRequest *)requestToEndPromotionWithId:(NSUInteger)promotionId;

@end
