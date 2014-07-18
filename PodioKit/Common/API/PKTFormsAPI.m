//
//  PKTFormsAPI.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 02/07/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTFormsAPI.h"

@implementation PKTFormsAPI

+ (PKTRequest *)requestForFormWithID:(NSUInteger)formID {
  return [PKTRequest GETRequestWithPath:PKTRequestPath(@"/form/%lu", (unsigned long)formID) parameters:nil];
}

@end
