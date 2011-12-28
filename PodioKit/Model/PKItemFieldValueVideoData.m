//
//  POTransformableVideoData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 7/19/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueVideoData.h"


static NSString * const POTransformableVideoDataFileIdKey = @"FileId";
static NSString * const POTransformableVideoDataDescriptionKey = @"Description";
static NSString * const POTransformableVideoDataLinkKey = @"Link";
static NSString * const POTransformableVideoDataMimeTypeKey = @"MimeType";
static NSString * const POTransformableVideoDataNameKey = @"Name";
static NSString * const POTransformableVideoDataSizeKey = @"Size";

@implementation PKItemFieldValueVideoData

@synthesize fileId = fileId_;
@synthesize descr = descr_;
@synthesize link = link_;
@synthesize mimeType = mimeType_;
@synthesize name = name_;
@synthesize size = size_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    fileId_ = [aDecoder decodeIntegerForKey:POTransformableVideoDataFileIdKey];
    descr_ = [[aDecoder decodeObjectForKey:POTransformableVideoDataDescriptionKey] copy];
    link_ = [[aDecoder decodeObjectForKey:POTransformableVideoDataLinkKey] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:POTransformableVideoDataMimeTypeKey] copy];
    name_ = [[aDecoder decodeObjectForKey:POTransformableVideoDataNameKey] copy];
    size_ = [aDecoder decodeIntegerForKey:POTransformableVideoDataSizeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:fileId_ forKey:POTransformableVideoDataFileIdKey];
  [aCoder encodeObject:descr_ forKey:POTransformableVideoDataDescriptionKey];
  [aCoder encodeObject:link_ forKey:POTransformableVideoDataLinkKey];
  [aCoder encodeObject:mimeType_ forKey:POTransformableVideoDataMimeTypeKey];
  [aCoder encodeObject:name_ forKey:POTransformableVideoDataNameKey];
  [aCoder encodeInteger:size_ forKey:POTransformableVideoDataSizeKey];
}

- (void)dealloc {
  [descr_ release];
  [link_ release];
  [mimeType_ release];
  [name_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueVideoData *data = [self data];
  
  NSDictionary *videoDict = [dict pk_objectForKey:@"value"];
  data.fileId = [[videoDict pk_objectForKey:@"file_id"] integerValue];
  data.descr = [videoDict pk_objectForKey:@"description"];
  data.link = [videoDict pk_objectForKey:@"link"];
  data.mimeType = [videoDict pk_objectForKey:@"mime_type"];
  data.name = [videoDict pk_objectForKey:@"name"];
  data.size = [[videoDict pk_objectForKey:@"size"] integerValue];
  
  return data;
}

@end
