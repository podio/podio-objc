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
  NSString *path = PKTRequestPath(@"/item/app/%lu/", (unsigned long)appID);
  PKTRequest *request = [PKTRequest POSTRequestWithPath:path parameters:nil];
  
  request.body = [NSMutableDictionary new];
  
  if ([fields count] > 0) {
    request.body[@"fields"] = fields;
  }
  
  if ([files count] > 0) {
    request.body[@"files"] = files;
  }
  
  if ([tags count] > 0) {
    request.body[@"tags"] = tags;
  }
  
  return request;
}

+ (PKTRequest *)requestToUpdateItemWithID:(NSUInteger)itemID fields:(NSDictionary *)fields files:(NSArray *)files tags:(NSArray *)tags {
  NSString *path = PKTRequestPath(@"/item/%lu", (unsigned long)itemID);
  PKTRequest *request = [PKTRequest PUTRequestWithPath:path parameters:nil];
  
  request.body = [NSMutableDictionary new];
  
  if ([fields count] > 0) {
    request.body[@"fields"] = fields;
  }
  
  if ([files count] > 0) {
    request.body[@"files"] = files;
  }
  
  if ([tags count] > 0) {
    request.body[@"tags"] = tags;
  }
  
  return request;
}

@end
