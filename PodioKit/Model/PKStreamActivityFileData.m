//
//  POStreamActivityFileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/20/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamActivityFileData.h"

static NSString * const POStreamActivityFileDataFileId = @"FileId";
static NSString * const POStreamActivityFileDataName = @"Name";
static NSString * const POStreamActivityFileDataDescription = @"Description";
static NSString * const POStreamActivityFileDataMimeType = @"MimeType";
static NSString * const POStreamActivityFileDataSize = @"Size";

@implementation PKStreamActivityFileData

@synthesize fileId = fileId_;
@synthesize name = name_;
@synthesize description = description_;
@synthesize mimeType = mimeType_;
@synthesize size = size_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    fileId_ = [aDecoder decodeIntegerForKey:POStreamActivityFileDataFileId];
    name_ = [[aDecoder decodeObjectForKey:POStreamActivityFileDataName] copy];
    description_ = [[aDecoder decodeObjectForKey:POStreamActivityFileDataDescription] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:POStreamActivityFileDataMimeType] copy];
    size_ = [aDecoder decodeIntegerForKey:POStreamActivityFileDataSize];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:fileId_ forKey:POStreamActivityFileDataFileId];
  [aCoder encodeObject:name_ forKey:POStreamActivityFileDataName];
  [aCoder encodeObject:description_ forKey:POStreamActivityFileDataDescription];
  [aCoder encodeObject:mimeType_ forKey:POStreamActivityFileDataMimeType];
  [aCoder encodeInteger:size_ forKey:POStreamActivityFileDataSize];
}

- (void)dealloc {
  [name_ release];
  [description_ release];
  [mimeType_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamActivityFileData *data = [self data];
  
  data.fileId = [[dict pk_objectForKey:@"file_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  data.description = [dict pk_objectForKey:@"description"];
  data.mimeType = [dict pk_objectForKey:@"mimetype"];
  data.size = [[dict pk_objectForKey:@"size"] integerValue];
  
  return data;
}

@end
