//
//  PKItemFieldValueItemData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKItemFieldValueMediaData.h"


static NSString * const PKItemFieldValueItemDataEmbedCodeKey = @"EmbedCode";
static NSString * const PKItemFieldValueItemDataProviderKey = @"Provider";
static NSString * const PKItemFieldValueItemDataVideoIdKey = @"VideoId";

@implementation PKItemFieldValueMediaData

@synthesize embedCode = embedCode_;
@synthesize provider = provider_;
@synthesize videoId = videoId_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    embedCode_ = [[aDecoder decodeObjectForKey:PKItemFieldValueItemDataEmbedCodeKey] copy];
    provider_ = [[aDecoder decodeObjectForKey:PKItemFieldValueItemDataProviderKey] copy];
    videoId_ = [[aDecoder decodeObjectForKey:PKItemFieldValueItemDataVideoIdKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:embedCode_ forKey:PKItemFieldValueItemDataEmbedCodeKey];
  [aCoder encodeObject:provider_ forKey:PKItemFieldValueItemDataProviderKey];
  [aCoder encodeObject:videoId_ forKey:PKItemFieldValueItemDataVideoIdKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueMediaData *data = [self data];
  
  data.embedCode = [dict pk_objectForKey:@"embed_code"];
  data.provider = [dict pk_objectForKey:@"provider"];
  data.videoId = [dict pk_objectForKey:@"video_id"];
  
  return data;
}

@end
