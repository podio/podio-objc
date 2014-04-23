//
//  PKTComment.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 22/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTComment.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTComment

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"commentID": @"comment_id",
    @"referenceType": @"ref.type",
    @"referenceID": @"ref.id",
    @"value": @"value",
    @"richValue": @"rich_value",
  };
}

+ (NSValueTransformer *)referenceTypeValueTransformer {
  return [NSValueTransformer pkt_referenceTypeTransformer];
}

@end
