//
//  PKItemFieldValueEmbedData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueEmbedData.h"



static NSString * const PKItemFieldValueEmbedDataEmbedIdKey = @"EmbedId";
static NSString * const PKItemFieldValueEmbedDataTypeKey = @"Type";
static NSString * const PKItemFieldValueEmbedDataTitleKey = @"Title";
static NSString * const PKItemFieldValueEmbedDataDescriptionKey = @"Description";
static NSString * const PKItemFieldValueEmbedDataResolvedURLKey = @"ResolvedURL";
static NSString * const PKItemFieldValueEmbedDataOriginalURLKey = @"OriginalURL";

static NSString * const PKItemFieldValueEmbedDataFileIdKey = @"FileId";
static NSString * const PKItemFieldValueEmbedDataFileLinkKey = @"FileLink";
static NSString * const PKItemFieldValueEmbedDataFileMimeTypeKey = @"FileMimeType";

@implementation PKItemFieldValueEmbedData

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
    embedId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueEmbedDataEmbedIdKey];
    type_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataTypeKey] copy];
    title_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataTitleKey] copy];
    descr_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataDescriptionKey] copy];
    resolvedURL_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataResolvedURLKey] copy];
    originalURL_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataOriginalURLKey] copy];
    
    fileId_ = [aDecoder decodeIntegerForKey:PKItemFieldValueEmbedDataFileIdKey];
    fileLink_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataFileLinkKey] copy];
    fileMimeType_ = [[aDecoder decodeObjectForKey:PKItemFieldValueEmbedDataFileMimeTypeKey] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:embedId_ forKey:PKItemFieldValueEmbedDataEmbedIdKey];
  [aCoder encodeObject:type_ forKey:PKItemFieldValueEmbedDataTypeKey];
  [aCoder encodeObject:title_ forKey:PKItemFieldValueEmbedDataTitleKey];
  [aCoder encodeObject:descr_ forKey:PKItemFieldValueEmbedDataDescriptionKey];
  [aCoder encodeObject:resolvedURL_ forKey:PKItemFieldValueEmbedDataResolvedURLKey];
  [aCoder encodeObject:originalURL_ forKey:PKItemFieldValueEmbedDataOriginalURLKey];
  
  [aCoder encodeInteger:fileId_ forKey:PKItemFieldValueEmbedDataFileIdKey];
  [aCoder encodeObject:fileLink_ forKey:PKItemFieldValueEmbedDataFileLinkKey];
  [aCoder encodeObject:fileMimeType_ forKey:PKItemFieldValueEmbedDataFileMimeTypeKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueEmbedData *data = [self data];
  
  NSDictionary *embedDict = [dict pk_objectForKey:@"embed"];
  data.embedId = [[embedDict pk_objectForKey:@"embed_id"] integerValue];
  data.type = [embedDict pk_objectForKey:@"type"];
  data.title = [embedDict pk_objectForKey:@"title"];
  data.descr = [embedDict pk_objectForKey:@"description"];
  data.originalURL = [embedDict pk_objectForKey:@"original_url"];
  data.resolvedURL = [embedDict pk_objectForKey:@"resolved_url"];
  
  NSDictionary *fileDict = [dict pk_objectForKey:@"file"];
  if (fileDict != nil) {
    data.fileId = [[fileDict pk_objectForKey:@"file_id"] integerValue];
    data.fileLink = [fileDict pk_objectForKey:@"link"];
    data.fileMimeType = [fileDict pk_objectForKey:@"mimetype"];
  }
  
  return data;
}

@end
