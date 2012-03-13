//
//  PKAppStoreAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKAppStoreAPI.h"

@implementation PKAppStoreAPI

+ (PKRequest *)requestForRecommendedSharesForArea:(PKAppStoreAPIRecommendedArea)area {
  NSString *areaString = nil;
  
  switch (area) {
    case PKAppStoreAPIRecommendedAreaWeb:
      areaString = @"web";
      break;
    case PKAppStoreAPIRecommendedAreaMobile:
      areaString = @"mobile";
      break;
    default:
      break;
  }
  
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/recommended/%@/", areaString] method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestForCategories {
  return [PKRequest requestWithURI:@"/app_store/category/" method:PKAPIRequestMethodGET];
}

+ (PKRequest *)requestForSharesInCategoryWithId:(NSUInteger)categoryId {
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/category/%d/", categoryId] method:PKAPIRequestMethodGET];
}

@end
