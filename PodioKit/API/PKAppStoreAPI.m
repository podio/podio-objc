//
//  PKAppStoreAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/13/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
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
  
  return [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/recommended/%@/", areaString] method:PKRequestMethodGET];
}

+ (PKRequest *)requestForCategories {
  return [PKRequest requestWithURI:@"/app_store/category/" method:PKRequestMethodGET];
}

+ (PKRequest *)requestForSharesInCategoryWithId:(NSUInteger)categoryId type:(PKAppStoreAPIShareType)type sortOrder:(PKAppStoreAPISortOrder)sortOrder 
                                       language:(NSString *)language offset:(NSUInteger)offset limit:(NSUInteger)limit {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/category/%d/", categoryId] method:PKRequestMethodGET];
  
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
  
  if (language != nil) {
    [request.parameters setObject:language forKey:@"language"];
  }
  
  if (offset > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", offset] forKey:@"offset"];
  }
  
  if (limit > 0) {
    [request.parameters setObject:[NSString stringWithFormat:@"%d", limit] forKey:@"limit"];
  }
  
  return request;
}

+ (PKRequest *)requestToInstallShareWithId:(NSUInteger)shareId spaceId:(NSUInteger)spaceId {
  return [self requestToInstallShareWithId:shareId spaceId:spaceId dependencies:nil];
}

+ (PKRequest *)requestToInstallShareWithId:(NSUInteger)shareId spaceId:(NSUInteger)spaceId dependencies:(NSArray *)dependencies {
  PKRequest *request = [PKRequest requestWithURI:[NSString stringWithFormat:@"/app_store/%d/install/v2", shareId] method:PKRequestMethodPOST];
  
  request.body = [NSMutableDictionary dictionaryWithObject:@(spaceId) forKey:@"space_id"];
  
  if ([dependencies count] > 0) {
    [request.body setObject:dependencies forKey:@"dependencies"];
  }
  
  return request;
}

@end
