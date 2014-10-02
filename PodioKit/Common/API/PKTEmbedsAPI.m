//
//  PKTEmbedsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/10/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTEmbedsAPI.h"

@implementation PKTEmbedsAPI

+ (PKTRequest *)requestToAddEmbedWithURLString:(NSString *)URLString {
  NSParameterAssert(URLString);
  
  return [PKTRequest POSTRequestWithPath:@"/embed/" parameters:@{@"url" : URLString}];
}

@end
