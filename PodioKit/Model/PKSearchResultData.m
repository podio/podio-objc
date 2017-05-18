//
//  PKSearchResultData.m
//  PodioKit
//
//  Created by Sebastian Rehnby on 3/3/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
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
static NSString * const PKSearchResultDataOrgId = @"OrganizationId";
static NSString * const PKSearchResultDataOrgName = @"OrganizationName";

@implementation PKSearchResultData

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _referenceType = [aDecoder decodeIntForKey:PKSearchResultDataReferenceType];
    _referenceId = [aDecoder decodeIntegerForKey:PKSearchResultDataReferenceId];
    _title = [[aDecoder decodeObjectForKey:PKSearchResultDataTitle] copy];
    _appName = [[aDecoder decodeObjectForKey:PKSearchResultDataAppName] copy];
    _appItemName = [[aDecoder decodeObjectForKey:PKSearchResultDataAppItemName] copy];
    _appIcon = [[aDecoder decodeObjectForKey:PKSearchResultDataAppIcon] copy];
    _spaceId = [aDecoder decodeIntegerForKey:PKSearchResultDataSpaceId];
    _spaceName = [[aDecoder decodeObjectForKey:PKSearchResultDataSpaceName] copy];
    _orgId = [aDecoder decodeIntegerForKey:PKSearchResultDataOrgId];
    _orgName = [[aDecoder decodeObjectForKey:PKSearchResultDataOrgName] copy];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeInt:_referenceType forKey:PKSearchResultDataReferenceType];
  [aCoder encodeInteger:_referenceId forKey:PKSearchResultDataReferenceId];
  [aCoder encodeObject:_title forKey:PKSearchResultDataTitle];
  [aCoder encodeObject:_appName forKey:PKSearchResultDataAppName];
  [aCoder encodeObject:_appItemName forKey:PKSearchResultDataAppItemName];
  [aCoder encodeObject:_appIcon forKey:PKSearchResultDataAppIcon];
  [aCoder encodeInteger:_spaceId forKey:PKSearchResultDataSpaceId];
  [aCoder encodeObject:_spaceName forKey:PKSearchResultDataSpaceName];
  [aCoder encodeInteger:_orgId forKey:PKSearchResultDataOrgId];
  [aCoder encodeObject:_orgName forKey:PKSearchResultDataOrgName];
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
  data.orgId = [[[dict pk_objectForKey:@"org"] pk_objectForKey:@"org_id"] integerValue];
  data.orgName = [[dict pk_objectForKey:@"org"] pk_objectForKey:@"name"];
  
  return data;
}

@end
