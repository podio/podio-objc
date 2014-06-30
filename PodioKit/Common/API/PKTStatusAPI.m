//
//  PKTStatusAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 30/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTStatusAPI.h"

@implementation PKTStatusAPI

+ (PKTRequest *)requestForStatusMessageWithID:(NSUInteger)statusID {
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/status/%lu", (unsigned long)statusID) parameters:nil];
}

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID {
  return [self requestToAddNewStatusMessageWithText:text spaceID:spaceID files:nil];
}

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files {
  return [self requestToAddNewStatusMessageWithText:text spaceID:spaceID files:files embedID:0];
}

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedID:(NSUInteger)embedID {
  return [self requestToAddNewStatusMessageWithText:text spaceID:spaceID files:files embedID:embedID embedURL:nil];
}

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedURL:(NSURL *)embedURL {
  return [self requestToAddNewStatusMessageWithText:text spaceID:spaceID files:files embedID:0 embedURL:embedURL];
}

+ (PKTRequest *)requestToAddNewStatusMessageWithText:(NSString *)text spaceID:(NSUInteger)spaceID files:(NSArray *)files embedID:(NSUInteger)embedID embedURL:(NSURL *)embedURL {
  NSParameterAssert(text);
  
  NSMutableDictionary *params = [NSMutableDictionary new];
  params[@"value"] = text;
  
  if ([files count] > 0) {
    params[@"file_ids"] = files;
  }
  
  if (embedID > 0) {
    params[@"embed_id"] = @(embedID);
  } else if (embedURL) {
    params[@"embed_url"] = [embedURL absoluteString];
  }
  
  return [PKTRequest POSTRequestWithPath:PKTRequestPath(@"/status/space/%lu/", (unsigned long)spaceID) parameters:[params copy]];
}

@end
