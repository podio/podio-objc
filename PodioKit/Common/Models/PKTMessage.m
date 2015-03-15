//
//  PKTMessage.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 13/11/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTMessage.h"
#import "PKTFile.h"
#import "PKTEmbed.h"
#import "NSValueTransformer+PKTTransformers.h"

@implementation PKTMessage

#pragma mark - PKTModel

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"messageID": @"message_id"
  };
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)embedValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTEmbed class]];
}

@end
