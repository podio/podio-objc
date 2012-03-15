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

+ (PKRequest *)requestForSharesInCategoryWithId:(NSUInteger)categoryId type:(PKAppStoreAPIShareType)type sortOrder:(PKAppStoreAPISortOrder)sortOrder {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/category/%d/", categoryId] method:PKAPIRequestMethodGET];
  
  NSString *typeString = nil;
  switch (type) {
    case PKAppStoreAPIShareTypeApp:
      typeString = @"app";
      break;
    case PKAppStoreAPIShareTypePack:
      typeString = @"pack";
      break;
    default:
      break;
  }
  
  if (typeString != nil) {
    [request.parameters setObject:typeString forKey:@"type"];
  }
  
  NSString *sortString = nil;
  switch (sortOrder) {
    case PKAppStoreAPISortOrderInstall:
      sortString = @"install";
      break;
    case PKAppStoreAPISortOrderRating:
      sortString = @"rating";
      break;
    case PKAppStoreAPISortOrderPopularity:
      sortString = @"popularity";
      break;
    case PKAppStoreAPISortOrderName:
      sortString = @"name";
      break;
    default:
      break;
  }
  
  if (sortString != nil) {
    [request.parameters setObject:sortString forKey:@"sort"];
  }
  
  return request;
}

+ (PKRequest *)requestToInstallShareWithId:(NSUInteger)shareId spaceId:(NSUInteger)spaceId {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/%d/install/v2", shareId] method:PKAPIRequestMethodPOST];
  request.body = [NSDictionary dictionaryWithObject:[NSNumber numberWithUnsignedInteger:spaceId] forKey:@"space_id"];
  
  return request;
}

@end
