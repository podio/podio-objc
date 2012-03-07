//
//  PKSearchResultData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/3/12.
//  Copyright (c) 2012 Podio. All rights reserved.
//

#import "PKSearchResultData.h"

static NSString * const PKSearchResultDataReferenceType = @"ReferenceType";
static NSString * const PKSearchResultDataReferenceId = @"ReferenceId";
static NSString * const PKSearchResultDataTitle = @"Title";
static NSString * const PKSearchResultDataAppName = @"AppName";
static NSString * const PKSearchResultDataAppItemName = @"AppItemName";
static NSString * const PKSearchResultDataAppIcon = @"AppIcon";
static NSString * const PKSearchResultDataSpaceId = @"SpaceId";
static NSString * const PKSearchResultDataSpaceName = @"spaceName";

@implementation PKSearchResultData

@synthesize referenceType = referenceType_;
@synthesize referenceId = referenceId_;
@synthesize title = title_;
@synthesize appName = appName_;
@synthesize appItemName = appItemName_;
@synthesize appIcon = appIcon_;
@synthesize spaceId = spaceId_;
@synthesize spaceName = spaceName_;
@synthesize createdBy = createdBy_;

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    referenceType_ = [aDecoder decodeIntegerForKey:PKSearchResultDataReferenceType];
    referenceId_ = [aDecoder decodeIntegerForKey:PKSearchResultDataReferenceId];
    title_ = [[aDecoder decodeObjectForKey:PKSearchResultDataTitle] copy];
    appName_ = [[aDecoder decodeObjectForKey:PKSearchResultDataAppName] copy];
    appItemName_ = [[aDecoder decodeObjectForKey:PKSearchResultDataAppItemName] copy];
    appIcon_ = [[aDecoder decodeObjectForKey:PKSearchResultDataAppIcon] copy];
    spaceId_ = [aDecoder decodeIntegerForKey:PKSearchResultDataSpaceId];
    spaceName_ = [[aDecoder decodeObjectForKey:PKSearchResultDataSpaceName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInteger:referenceType_ forKey:PKSearchResultDataReferenceType];
  [aCoder encodeInteger:referenceId_ forKey:PKSearchResultDataReferenceId];
  [aCoder encodeObject:title_ forKey:PKSearchResultDataTitle];
  [aCoder encodeObject:appName_ forKey:PKSearchResultDataAppName];
  [aCoder encodeObject:appItemName_ forKey:PKSearchResultDataAppItemName];
  [aCoder encodeObject:appIcon_ forKey:PKSearchResultDataAppIcon];
  [aCoder encodeInteger:spaceId_ forKey:PKSearchResultDataSpaceId];
  [aCoder encodeObject:spaceName_ forKey:PKSearchResultDataSpaceName];
}

#pragma mark - Factory methods

+ (id)dataFromDictionary:(NSDictionary *)dict {
  PKSearchResultData *data = [self data];
  
  data.referenceType = [PKConstants referenceTypeForString:[dict pk_objectForKey:@"type"]];
  data.referenceId = [[dict pk_objectForKey:@"id"] integerValue];
  data.title = [dict pk_objectForKey:@"title"];
  data.appName = [[[dict pk_objectForKey:@"app"] pk_objectForKey:@"config"] pk_objectForKey:@"name"];
  data.appItemName = [[[dict pk_objectForKey:@"app"] pk_objectForKey:@"config"] pk_objectForKey:@"item_name"];
  data.appIcon = [[[dict pk_objectForKey:@"app"] pk_objectForKey:@"config"] pk_objectForKey:@"icon"];
  data.spaceId = [[[dict pk_objectForKey:@"space"] pk_objectForKey:@"space_id"] integerValue];
  data.spaceName = [[dict pk_objectForKey:@"space"] pk_objectForKey:@"name"];
  data.createdBy = [PKByLineData dataFromDictionary:[dict pk_objectForKey:@"created_by"]];
  
  return data;
}

@end
