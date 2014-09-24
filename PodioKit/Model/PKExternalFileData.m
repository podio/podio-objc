//
//  PKExternalFileData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 2/28/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "PKExternalFileData.h"
#import "NSDate+PKFormatting.h"


static NSString * const PKExternalFileDataExternalFileIdKey = @"ExternalFileId";
static NSString * const PKExternalFileDataNameKey = @"Name";
static NSString * const PKExternalFileDataMimeTypeKey = @"MimeType";
static NSString * const PKExternalFileDataCreatedOnKey = @"CreatedOn";
static NSString * const PKExternalFileDataUpdatedOnKey = @"UpdatedOn";
static NSString * const PKExternalFileDataIsFolderKey = @"IsFolder";

@implementation PKExternalFileData

@synthesize externalFileId = externalFileId_;
@synthesize name = name_;
@synthesize mimeType = mimeType_;
@synthesize createdOn = createdOn_;
@synthesize updatedOn = updatedOn_;
@synthesize isFolder = isFolder_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    externalFileId_ = [[aDecoder decodeObjectForKey:PKExternalFileDataExternalFileIdKey] copy];
    name_ = [[aDecoder decodeObjectForKey:PKExternalFileDataNameKey] copy];
    mimeType_ = [[aDecoder decodeObjectForKey:PKExternalFileDataMimeTypeKey] copy];
    createdOn_ = [[aDecoder decodeObjectForKey:PKExternalFileDataCreatedOnKey] copy];
    updatedOn_ = [[aDecoder decodeObjectForKey:PKExternalFileDataUpdatedOnKey] copy];
    isFolder_ = [aDecoder decodeBoolForKey:PKExternalFileDataIsFolderKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeObject:externalFileId_ forKey:PKExternalFileDataExternalFileIdKey];
  [aCoder encodeObject:name_ forKey:PKExternalFileDataNameKey];
  [aCoder encodeObject:mimeType_ forKey:PKExternalFileDataMimeTypeKey];
  [aCoder encodeObject:createdOn_ forKey:PKExternalFileDataCreatedOnKey];
  [aCoder encodeObject:updatedOn_ forKey:PKExternalFileDataUpdatedOnKey];
  [aCoder encodeBool:isFolder_ forKey:PKExternalFileDataIsFolderKey];
}


#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKExternalFileData *data = [self data];
  
  id externalFileId = [dict pk_objectForKey:@"external_file_id"];
  if ([externalFileId isKindOfClass:[NSNumber class]]) {
    externalFileId = [externalFileId stringValue];
  }
  
  data.externalFileId = externalFileId;
  data.name = [dict pk_objectForKey:@"name"];
  data.mimeType = [dict pk_objectForKey:@"mimetype"];
  data.createdOn = [NSDate pk_dateFromUTCDateTimeString:[dict pk_objectForKey:@"created_on"]];
  data.updatedOn = [NSDate pk_dateFromUTCDateTimeString:[dict pk_objectForKey:@"updated_on"]];
  data.isFolder = [data.mimeType isEqualToString:@"folder"];
  
  return data;
}

@end
