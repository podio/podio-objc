//
//  PKTNotificationsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 08/09/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTNotificationsAPI.h"

@implementation PKTNotificationsAPI

+ (PKTRequest *)requestForNotificationsWithOffset:(NSUInteger)offset limit:(NSUInteger)limit {
  return [self requestForNotificationsWithParameters:nil offset:offset limit:limit];
}

+ (PKTRequest *)requestForNotificationsWithParameters:(PKTNotificationsRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit {
  NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:parameters.queryParameters];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:@"/notification/" parameters:params];
}

@end
