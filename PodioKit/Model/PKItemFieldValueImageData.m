//
//  POTransformableImageData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2011-07-11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKItemFieldValueImageData.h"


static NSString * const POTransformableImageDataFileIdKey = @"FileId";
static NSString * const POTransformableImageDataLinkKey = @"Link";
static NSString * const POTransformableImageDataMimeTypeKey = @"MimeType";
static NSString * const POTransformableImageDataNameKey = @"Name";
static NSString * const POTransformableImageDataSizeKey = @"Size";

@implementation PKItemFieldValueImageData

@synthesize fileId = fileId_;
@synthesize link = link_;
@synthesize mimeType = mimeType_;
@synthesize name = name_;
@synthesize size = size_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    fileId_ = [aDecoder decodeIntegerForKey:POTransformableImageDataFileIdKey];
    link_ = [[aDecoder decodeObjectForKey:POTransformableImageDataLinkKey] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:POTransformableImageDataMimeTypeKey] copy];
    name_ = [[aDecoder decodeObjectForKey:POTransformableImageDataNameKey] copy];
    size_ = [aDecoder decodeIntegerForKey:POTransformableImageDataSizeKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:fileId_ forKey:POTransformableImageDataFileIdKey];
  [aCoder encodeObject:link_ forKey:POTransformableImageDataLinkKey];
  [aCoder encodeObject:mimeType_ forKey:POTransformableImageDataMimeTypeKey];
  [aCoder encodeObject:name_ forKey:POTransformableImageDataNameKey];
  [aCoder encodeInteger:size_ forKey:POTransformableImageDataSizeKey];
}

- (void)dealloc {
  [link_ release];
  [mimeType_ release];
  [name_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKItemFieldValueImageData *data = [self data];
  
  NSDictionary *imgDict = [dict pk_objectForKey:@"value"];
  data.fileId = [[imgDict pk_objectForKey:@"file_id"] integerValue];
  data.link = [imgDict pk_objectForKey:@"link"];
  data.mimeType = [imgDict pk_objectForKey:@"mime_type"];
  data.name = [imgDict pk_objectForKey:@"name"];
  data.size = [[imgDict pk_objectForKey:@"size"] integerValue];
  
  return data;
}

@end
