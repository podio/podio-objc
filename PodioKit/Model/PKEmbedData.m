//
//  PKEmbedData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKEmbedData.h"

static NSString * const PKEmbedDataEmbedIdKey = @"EmbedId";
static NSString * const PKEmbedDataTypeKey = @"Type";
static NSString * const PKEmbedDataTitleKey = @"Title";
static NSString * const PKEmbedDataDescriptionKey = @"Description";
static NSString * const PKEmbedDataResolvedURLKey = @"ResolvedURL";
static NSString * const PKEmbedDataOriginalURLKey = @"OriginalURL";

static NSString * const PKEmbedDataFileIdKey = @"FileId";
static NSString * const PKEmbedDataFileLinkKey = @"FileLink";
static NSString * const PKEmbedDataFileMimeTypeKey = @"FileMimeType";

@implementation PKEmbedData

@synthesize embedId = embedId_;
@synthesize type = type_;
@synthesize title = title_;
@synthesize descr = descr_;
@synthesize resolvedURL = resolvedURL_;
@synthesize originalURL = originalURL_;
@synthesize fileId = fileId_;
@synthesize fileLink = fileLink_;
@synthesize fileMimeType = fileMimeType_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    embedId_ = [aDecoder decodeIntegerForKey:PKEmbedDataEmbedIdKey];
    type_ = [[aDecoder decodeObjectForKey:PKEmbedDataTypeKey] copy];
    title_ = [[aDecoder decodeObjectForKey:PKEmbedDataTitleKey] copy];
    descr_ = [[aDecoder decodeObjectForKey:PKEmbedDataDescriptionKey] copy];
    resolvedURL_ = [[aDecoder decodeObjectForKey:PKEmbedDataResolvedURLKey] copy];
    originalURL_ = [[aDecoder decodeObjectForKey:PKEmbedDataOriginalURLKey] copy];
    
    fileId_ = [aDecoder decodeIntegerForKey:PKEmbedDataFileIdKey];
    fileLink_ = [[aDecoder decodeObjectForKey:PKEmbedDataFileLinkKey] copy];
    fileMimeType_ = [[aDecoder decodeObjectForKey:PKEmbedDataFileMimeTypeKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:embedId_ forKey:PKEmbedDataEmbedIdKey];
  [aCoder encodeObject:type_ forKey:PKEmbedDataTypeKey];
  [aCoder encodeObject:title_ forKey:PKEmbedDataTitleKey];
  [aCoder encodeObject:descr_ forKey:PKEmbedDataDescriptionKey];
  [aCoder encodeObject:resolvedURL_ forKey:PKEmbedDataResolvedURLKey];
  [aCoder encodeObject:originalURL_ forKey:PKEmbedDataOriginalURLKey];
  
  [aCoder encodeInteger:fileId_ forKey:PKEmbedDataFileIdKey];
  [aCoder encodeObject:fileLink_ forKey:PKEmbedDataFileLinkKey];
  [aCoder encodeObject:fileMimeType_ forKey:PKEmbedDataFileMimeTypeKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  NSDictionary *embedDict = [dict pk_objectForKey:@"embed"];
  if (!embedDict) {
    return nil;
  }
  
  PKEmbedData *data = [self data];
  
  data.embedId = [[embedDict pk_objectForKey:@"embed_id"] integerValue];
  data.type = [embedDict pk_objectForKey:@"type"];
  data.title = [embedDict pk_objectForKey:@"title"];
  data.descr = [embedDict pk_objectForKey:@"description"];
  data.originalURL = [embedDict pk_objectForKey:@"original_url"];
  data.resolvedURL = [embedDict pk_objectForKey:@"resolved_url"];
  
  NSDictionary *fileDict = [dict pk_objectForKey:@"embed_file"];
  if (fileDict != nil) {
    data.fileId = [[fileDict pk_objectForKey:@"file_id"] integerValue];
    data.fileLink = [fileDict pk_objectForKey:@"link"];
    data.fileMimeType = [fileDict pk_objectForKey:@"mimetype"];
  }

  return data;
}

@end
