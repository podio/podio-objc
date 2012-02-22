//
//  POEmbedData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKEmbedData.h"

static NSString * const POTransformableEmbedDataEmbedIdKey = @"EmbedId";
static NSString * const POTransformableEmbedDataTypeKey = @"Type";
static NSString * const POTransformableEmbedDataTitleKey = @"Title";
static NSString * const POTransformableEmbedDataDescriptionKey = @"Description";
static NSString * const POTransformableEmbedDataResolvedURLKey = @"ResolvedURL";
static NSString * const POTransformableEmbedDataOriginalURLKey = @"OriginalURL";

static NSString * const POTransformableEmbedDataFileIdKey = @"FileId";
static NSString * const POTransformableEmbedDataFileLinkKey = @"FileLink";
static NSString * const POTransformableEmbedDataFileMimeTypeKey = @"FileMimeType";

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
    embedId_ = [aDecoder decodeIntegerForKey:POTransformableEmbedDataEmbedIdKey];
    type_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataTypeKey] copy];
    title_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataTitleKey] copy];
    descr_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataDescriptionKey] copy];
    resolvedURL_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataResolvedURLKey] copy];
    originalURL_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataOriginalURLKey] copy];
    
    fileId_ = [aDecoder decodeIntegerForKey:POTransformableEmbedDataFileIdKey];
    fileLink_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataFileLinkKey] copy];
    fileMimeType_ = [[aDecoder decodeObjectForKey:POTransformableEmbedDataFileMimeTypeKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:embedId_ forKey:POTransformableEmbedDataEmbedIdKey];
  [aCoder encodeObject:type_ forKey:POTransformableEmbedDataTypeKey];
  [aCoder encodeObject:title_ forKey:POTransformableEmbedDataTitleKey];
  [aCoder encodeObject:descr_ forKey:POTransformableEmbedDataDescriptionKey];
  [aCoder encodeObject:resolvedURL_ forKey:POTransformableEmbedDataResolvedURLKey];
  [aCoder encodeObject:originalURL_ forKey:POTransformableEmbedDataOriginalURLKey];
  
  [aCoder encodeInteger:fileId_ forKey:POTransformableEmbedDataFileIdKey];
  [aCoder encodeObject:fileLink_ forKey:POTransformableEmbedDataFileLinkKey];
  [aCoder encodeObject:fileMimeType_ forKey:POTransformableEmbedDataFileMimeTypeKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKEmbedData *data = [self data];
  
  NSDictionary *embedDict = [dict pk_objectForKey:@"embed"];
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
