//
//  PKEmbedAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/17/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKEmbedAPI.h"

@implementation PKEmbedAPI

+ (PKRequest *)requestToCreateEmbedWithURLString:(NSString *)urlString {
  PKRequest *request = [PKRequest requestWithURI:@"/embed/" method:PKRequestMethodPOST];
  request.body = @{@"url": urlString};
  
  return request;
}

@end
