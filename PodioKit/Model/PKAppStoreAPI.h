//
//  PKAppStoreAPI.h
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKBaseAPI.h"

typedef enum {
  PKAppStoreAPIRecommendedAreaWeb = 0,
  PKAppStoreAPIRecommendedAreaMobile,
} PKAppStoreAPIRecommendedArea;

@interface PKAppStoreAPI : PKBaseAPI

+ (PKRequest *)requestForRecommendedSharesForArea:(PKAppStoreAPIRecommendedArea)area;

+ (PKRequest *)requestForCategories;
+ (PKRequest *)requestForSharesInCategoryWithId:(NSUInteger)categoryId;

@end
