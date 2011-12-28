//
//  POStreamFileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 9/21/11.
//  Copyright 2011 Podio. All rights reserved.
//

#import "PKStreamFileData.h"


static NSString * const POStreamFileDataFileId = @"FileId";
static NSString * const POStreamFileDataName = @"Name";
static NSString * const POStreamFileDataDescription = @"Description";
static NSString * const POStreamFileDataMimeType = @"MimeType";
static NSString * const POStreamFileDataSize = @"Size";

@implementation PKStreamFileData

@synthesize fileId = fileId_;
@synthesize name = name_;
@synthesize description = description_;
@synthesize mimeType = mimeType_;
@synthesize size = size_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    fileId_ = [aDecoder decodeIntegerForKey:POStreamFileDataFileId];
    name_ = [[aDecoder decodeObjectForKey:POStreamFileDataName] copy];
    description_ = [[aDecoder decodeObjectForKey:POStreamFileDataDescription] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:POStreamFileDataMimeType] copy];
    size_ = [aDecoder decodeIntegerForKey:POStreamFileDataSize];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:fileId_ forKey:POStreamFileDataFileId];
  [aCoder encodeObject:name_ forKey:POStreamFileDataName];
  [aCoder encodeObject:description_ forKey:POStreamFileDataDescription];
  [aCoder encodeObject:mimeType_ forKey:POStreamFileDataMimeType];
  [aCoder encodeInteger:size_ forKey:POStreamFileDataSize];
}

- (void)dealloc {
  [name_ release];
  [description_ release];
  [mimeType_ release];
  [super dealloc];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKStreamFileData *data = [self data];
  
  data.fileId = [[dict pk_objectForKey:@"file_id"] integerValue];
  data.name = [dict pk_objectForKey:@"name"];
  data.description = [dict pk_objectForKey:@"description"];
  data.mimeType = [dict pk_objectForKey:@"mimetype"];
  data.size = [[dict pk_objectForKey:@"size"] integerValue];
  
  return data;
}

@end
