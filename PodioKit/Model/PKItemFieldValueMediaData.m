//
//  POTransformableMediaData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueMediaData.h"


static NSString * const POTransformableMediaDataEmbedCodeKey = @"EmbedCode";
static NSString * const POTransformableMediaDataProviderKey = @"Provider";
static NSString * const POTransformableMediaDataVideoIdKey = @"VideoId";

@implementation PKItemFieldValueMediaData

@synthesize embedCode = embedCode_;
@synthesize provider = provider_;
@synthesize videoId = videoId_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    embedCode_ = [[aDecoder decodeObjectForKey:POTransformableMediaDataEmbedCodeKey] copy];
    provider_ = [[aDecoder decodeObjectForKey:POTransformableMediaDataProviderKey] copy];
    videoId_ = [[aDecoder decodeObjectForKey:POTransformableMediaDataVideoIdKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:embedCode_ forKey:POTransformableMediaDataEmbedCodeKey];
  [aCoder encodeObject:provider_ forKey:POTransformableMediaDataProviderKey];
  [aCoder encodeObject:videoId_ forKey:POTransformableMediaDataVideoIdKey];
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
