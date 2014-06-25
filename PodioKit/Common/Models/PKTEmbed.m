//
//  PKTEmbed.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTEmbed.h"

@implementation PKTEmbed

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"embedID" : @"embed_id"
           };
}

@end
