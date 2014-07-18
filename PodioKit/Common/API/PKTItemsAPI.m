//
//  PKTItemsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemsAPI.h"

@implementation PKTItemsAPI

+ (PKTRequest *)requestForItemWithID:(NSUInteger)itemID {
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/item/%lu", (unsigned long)itemID) parameters:nil];
}

+ (PKTRequest *)requestForReferencesForItemWithID:(NSUInteger)itemID {
  NSString *path = PKTRequestPath(@"/item/%lu/reference/", (unsigned long)itemID);
  PKTRequest *request = [PKTRequest GETRequestWithPath:path parameters:nil];
  
  return request;
}

+ (PKTRequest *)requestForFilteredItemsInAppWithID:(NSUInteger)appID offset:(NSUInteger)offset limit:(NSUInteger)limit sortBy:(NSString *)sortBy descending:(BOOL)descending remember:(BOOL)remember {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  parameters[@"offset"] = @(offset);
  parameters[@"limit"] = @(limit);
  parameters[@"sort_desc"] = @(descending);
  parameters[@"remember"] = @(remember);
  
  if (sortBy) {
    parameters[@"sort_by"] = sortBy;
  }
  
  NSString *path = PKTRequestPath(@"/item/app/%lu/filter/", (unsigned long)appID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:parameters];
  
  return request;
}

+ (PKTRequest *)requestForFilteredItemsInAppWithID:(NSUInteger)appID offset:(NSUInteger)offset limit:(NSUInteger)limit viewID:(NSUInteger)viewID remember:(BOOL)remember {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  parameters[@"offset"] = @(offset);
  parameters[@"limit"] = @(limit);
  parameters[@"remember"] = @(remember);

  NSString *path = PKTRequestPath(@"/item/app/%lu/filter/%lu/", (unsigned long)appID, (unsigned long)viewID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:parameters];

  return request;
}

+ (PKTRequest *)requestToCreateItemInAppWithID:(NSUInteger)appID fields:(NSDictionary *)fields files:(NSArray *)files tags:(NSArray *)tags {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  if ([fields count] > 0) {
    parameters[@"fields"] = fields;
  }
  
  if ([files count] > 0) {
    parameters[@"file_ids"] = files;
  }
  
  if ([tags count] > 0) {
    parameters[@"tags"] = tags;
  }
  
  NSString *path = PKTRequestPath(@"/item/app/%lu/", (unsigned long)appID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:parameters];
  
  return request;
}

+ (PKTRequest *)requestToUpdateItemWithID:(NSUInteger)itemID fields:(NSDictionary *)fields files:(NSArray *)files tags:(NSArray *)tags {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  if ([fields count] > 0) {
    parameters[@"fields"] = fields;
  }
  
  if ([files count] > 0) {
    parameters[@"file_ids"] = files;
  }
  
  if ([tags count] > 0) {
    parameters[@"tags"] = tags;
  }
  
  NSString *path = PKTRequestPath(@"/item/%lu", (unsigned long)itemID);
  PKTRequest *request = [PKTRequest PUTRequestWithPath:path parameters:parameters];
  
  return request;
}

@end
