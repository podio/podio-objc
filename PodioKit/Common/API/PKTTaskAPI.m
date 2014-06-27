//
//  PKTTaskAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 25/06/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTTaskAPI.h"

@implementation PKTTaskAPI

+ (PKTRequest *)requestForTasksWithParameters:(PKTTaskRequestParameters *)parameters offset:(NSUInteger)offset limit:(NSUInteger)limit; {
  NSMutableDictionary *params = [[parameters queryParameters] mutableCopy];
  
  if (offset > 0) {
    params[@"offset"] = @(offset);
  }
  
  if (limit > 0) {
    params[@"limit"] = @(limit);
  }
  
  return [PKTRequest GETRequestWithPath:@"/task/" parameters:[params copy]];
}

@end
