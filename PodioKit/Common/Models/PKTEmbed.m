//
//  PKTEmbed.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 28/04/14.
//  Copyright (c) 2014 Citrix Systems, Inc. All rights reserved.
//

#import "PKTEmbed.h"
#import "NSValueTransformer+PKTTransformers.h"
#import "PKTFile.h"

@implementation PKTEmbed

+ (NSDictionary *)dictionaryKeyPathsForPropertyNames {
  return @{
    @"embedID" : @"embed_id",
    @"originalURL": @"original_url",
    @"resolvedURL": @"resolved_url",
    @"type": @"type",
    @"title": @"title",
    @"descr": @"description",
    @"createdOn": @"created_on",
    @"providerName": @"provider_name",
    @"embedHTML": @"embed_html",
    @"embedWidth": @"embed_width",
    @"embedHeight": @"embed_height",
    @"files": @"files"
  };
}

+ (NSValueTransformer *)originalURLValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)resolvedURLValueTransformer {
  return [NSValueTransformer pkt_URLTransformer];
}

+ (NSValueTransformer *)createdOnValueTransformer {
  return [NSValueTransformer pkt_dateValueTransformer];
}

+ (NSValueTransformer *)filesValueTransformer {
  return [NSValueTransformer pkt_transformerWithModelClass:[PKTFile class]];
}

+ (NSValueTransformer *)embedWidthValueTransformer {
  return [NSValueTransformer pkt_numberValueTransformer];
}

+ (NSValueTransformer *)embedHeightValueTransformer {
  return [NSValueTransformer pkt_numberValueTransformer];
}

+ (NSValueTransformer *)typeValueTransformer {
  return [NSValueTransformer pkt_transformerWithDictionary:@{
    @"image" : @(PKTEmbedTypeImage),
    @"video" : @(PKTEmbedTypeVideo),
    @"rich" : @(PKTEmbedTypeRich),
    @"link" : @(PKTEmbedTypeLink),
    @"unresolved" : @(PKTEmbedTypeUnresolved)
  }];
}

@end
