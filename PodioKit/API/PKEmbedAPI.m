//
//  PKEmbedAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/17/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKEmbedAPI.h"

@implementation PKEmbedAPI

+ (PKRequest *)requestToCreateEmbedWithURLString:(NSString *)urlString {
  PKRequest *request = [PKRequest requestWithURI:@"/embed/" method:PKAPIRequestMethodPOST];
  request.body = [NSDictionary dictionaryWithObject:urlString forKey:@"url"];
  
  return request;
}

@end
