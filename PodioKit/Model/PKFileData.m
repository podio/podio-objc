//
//  PKFileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/2/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKFileData.h"

static NSString * const PKFileDataFileIdKey = @"FileId";
static NSString * const PKFileDataNameKey = @"Name";
static NSString * const PKFileDataDescriptionKey = @"Description";
static NSString * const PKFileDataHostedByKey = @"HostedBy";
static NSString * const PKFileDataLinkKey = @"Link";
static NSString * const PKFileDataThumbnailLinkKey = @"ThumbnailLink";
static NSString * const PKFileDataMimeTypeKey = @"MimeType";
static NSString * const PKFileDataSizeKey = @"Size";

@implementation PKFileData

@synthesize fileId = fileId_;
@synthesize name = name_;
@synthesize descr = descr_;
@synthesize hostedBy = hostedBy_;
@synthesize link = link_;
@synthesize thumbnailLink = thumbnailLink_;
@synthesize mimeType = mimeType_;
@synthesize size = size_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    fileId_ = [aDecoder decodeIntegerForKey:PKFileDataFileIdKey];
    name_ = [[aDecoder decodeObjectForKey:PKFileDataNameKey] copy];
    descr_ = [[aDecoder decodeObjectForKey:PKFileDataDescriptionKey] copy];
    hostedBy_ = [[aDecoder decodeObjectForKey:PKFileDataHostedByKey] copy];
    link_ = [[aDecoder decodeObjectForKey:PKFileDataLinkKey] copy];
    thumbnailLink_ = [[aDecoder decodeObjectForKey:PKFileDataThumbnailLinkKey] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:PKFileDataMimeTypeKey] copy];
    size_ = [aDecoder decodeIntegerForKey:PKFileDataSizeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:fileId_ forKey:PKFileDataFileIdKey];
  [aCoder encodeObject:name_ forKey:PKFileDataNameKey];
  [aCoder encodeObject:descr_ forKey:PKFileDataDescriptionKey];
  [aCoder encodeObject:hostedBy_ forKey:PKFileDataHostedByKey];
  [aCoder encodeObject:link_ forKey:PKFileDataLinkKey];
  [aCoder encodeObject:thumbnailLink_ forKey:PKFileDataThumbnailLinkKey];
  [aCoder encodeObject:mimeType_ forKey:PKFileDataMimeTypeKey];
  [aCoder encodeInteger:size_ forKey:PKFileDataSizeKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  if (dict == nil) return nil;
  
  PKFileData *data = [self data];
  
  data.fileId = [[dict pk_objectForKey:@"file_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  data.descr = [dict pk_objectForKey:@"description"];
  data.hostedBy = [dict pk_objectForKey:@"hosted_by"];
  data.link = [dict pk_objectForKey:@"link"];
  data.thumbnailLink = [dict pk_objectForKey:@"thumbnail_link"];
  data.mimeType = [dict pk_objectForKey:@"mimetype"];
  data.size = [[dict pk_objectForKey:@"size"] integerValue];
  
  return data;
}

@end
