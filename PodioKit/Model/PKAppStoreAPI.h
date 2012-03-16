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

typedef enum {
  PKAppStoreAPIShareTypeAll = 0,
  PKAppStoreAPIShareTypeApp,
  PKAppStoreAPIShareTypePack,
} PKAppStoreAPIShareType;

typedef enum {
  PKAppStoreAPISortOrderDefault = 0,
  PKAppStoreAPISortOrderInstall,
  PKAppStoreAPISortOrderRating,
  PKAppStoreAPISortOrderPopularity,
  PKAppStoreAPISortOrderName,
} PKAppStoreAPISortOrder;

@interface PKAppStoreAPI : PKBaseAPI

+ (PKRequest *)requestForRecommendedSharesForArea:(PKAppStoreAPIRecommendedArea)area;

+ (PKRequest *)requestForCategories;
+ (PKRequest *)requestForSharesInCategoryWithId:(NSUInteger)categoryId type:(PKAppStoreAPIShareType)type sortOrder:(PKAppStoreAPISortOrder)sortOrder language:(NSString *)language;
+ (PKRequest *)requestToInstallShareWithId:(NSUInteger)shareId spaceId:(NSUInteger)spaceId;

@end
