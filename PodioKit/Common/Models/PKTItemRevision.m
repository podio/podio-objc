//
//  PKTItemRevision.m
//  PodioKit
//
//  Created by Romain Briche on 23/03/15.
//  Copyright (c) 2015 Citrix Systems, Inc. All rights reserved.
//

#import "PKTItemRevision.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTItemRevision

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"itemRevisionID": @"item_revision_id"
  };
}

#pragma mark - Value transformers

+ (NSValueTransformer *)typeValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
    @"creation" : @(PKTItemRevisionTypeCreation),
    @"update" : @(PKTItemRevisionTypeUpdate),
    @"delete" : @(PKTItemRevisionTypeDelete),
  }];
}

@end
