//
//  PKUserAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/12/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKUserAPI.h"

@implementation PKUserAPI

+ (PKRequest *)requestForUserStatus {
  return [PKRequest requestWithURI:@"/user/status" method:PKAPIRequestMethodGET];
}

@end
