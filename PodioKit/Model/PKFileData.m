//
//  POFileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 10/2/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKFileData.h"

static NSString * const POFileDataFileIdKey = @"FileId";
static NSString * const POFileDataNameKey = @"Name";
static NSString * const POFileDataDescriptionKey = @"Description";
static NSString * const POFileDataHostedByKey = @"HostedBy";
static NSString * const POFileDataLinkKey = @"Link";
static NSString * const POFileDataThumbnailLinkKey = @"ThumbnailLink";
static NSString * const POFileDataMimeTypeKey = @"MimeType";
static NSString * const POFileDataSizeKey = @"Size";

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
    fileId_ = [aDecoder decodeIntegerForKey:POFileDataFileIdKey];
    name_ = [[aDecoder decodeObjectForKey:POFileDataNameKey] copy];
    descr_ = [[aDecoder decodeObjectForKey:POFileDataDescriptionKey] copy];
    hostedBy_ = [[aDecoder decodeObjectForKey:POFileDataHostedByKey] copy];
    link_ = [[aDecoder decodeObjectForKey:POFileDataLinkKey] copy];
    thumbnailLink_ = [[aDecoder decodeObjectForKey:POFileDataThumbnailLinkKey] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:POFileDataMimeTypeKey] copy];
    size_ = [aDecoder decodeIntegerForKey:POFileDataSizeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:fileId_ forKey:POFileDataFileIdKey];
  [aCoder encodeObject:name_ forKey:POFileDataNameKey];
  [aCoder encodeObject:descr_ forKey:POFileDataDescriptionKey];
  [aCoder encodeObject:hostedBy_ forKey:POFileDataHostedByKey];
  [aCoder encodeObject:link_ forKey:POFileDataLinkKey];
  [aCoder encodeObject:thumbnailLink_ forKey:POFileDataThumbnailLinkKey];
  [aCoder encodeObject:mimeType_ forKey:POFileDataMimeTypeKey];
  [aCoder encodeInteger:size_ forKey:POFileDataSizeKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
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
