//
//  PKTWorkspace.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 12/05/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTWorkspace.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTWorkspace

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
           @"spaceID" : @"space_id",
           @"organizationID" : @"org_id",
           @"linkURL" : @"url"
           };
}

+ (NSValueTransformer *)linkURLValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

@end
