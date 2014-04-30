//
//  PKTItemAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 31/03/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemAPI.h"

@implementation PKTItemAPI

+ (PKTRequest *)requestForItemWithID:(NSUInteger)itemID {
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/item/%lu", (unsigned long)itemID) parameters:nil];
}

+ (PKTRequest *)requestToCreateItemInAppWithID:(NSUInteger)appID fields:(NSDictionary *)fields files:(NSArray *)files tags:(NSArray *)tags {
  NSMutableDictionary *parameters = [NSMutableDictionary new];
  
  if ([fields count] > 0) {
    parameters[@"fields"] = fields;
  }
  
  if ([files count] > 0) {
    parameters[@"files"] = files;
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
    parameters[@"files"] = files;
  }
  
  if ([tags count] > 0) {
    parameters[@"tags"] = tags;
  }
  
  NSString *path = PKTRequestPath(@"/item/%lu", (unsigned long)itemID);
  PKTRequest *request = [PKTRequest PUTRequestWithPath:path parameters:parameters];
  
  return request;
}

@end
