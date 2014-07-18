//
//  PKTUsersAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 17/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTUsersAPI.h"

@implementation PKTUsersAPI

+ (PKTRequest *)requestForUserStatus {
  return [PKTRequest GETRequestWithPath:@"/user/status" parameters:nil];
}

@end
